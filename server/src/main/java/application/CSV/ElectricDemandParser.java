package application.CSV;

import application.Database.EnergyDB.Models.Building;
import application.Database.EnergyDB.Models.Usage;
import application.Database.EnergyDB.Repo.JPARepository.BuildingRepo;
import ErrorManagement.Error;
import application.Model.Response;
import com.opencsv.exceptions.CsvValidationException;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.IntStream;


public class ElectricDemandParser extends CsvParser {
    private final BuildingRepo buildingRepo;

    /**
     * Creates new ElectricDemandParser
     *
     * @param csvPath   - Path to the csv file to parse.
     * @param utilityID - Utility id for electric
     * @param repo      - Building repository to query
     * @throws FileNotFoundException
     */
    public ElectricDemandParser(String csvPath, int utilityID, BuildingRepo repo) throws FileNotFoundException {
        super(csvPath, utilityID);
        buildingRepo = repo;
    }

    /**
     * Generates map of the header to building relationship
     *
     * @return - Map where key = index in csv, and value is the building that represents it
     * @throws CsvValidationException - Throws if csv is incorrect format
     * @throws IOException            - Throws if can't access file or other IO errors
     */
    private Map<Integer, Building> generateHeaderMap() throws CsvValidationException, IOException {
        // Create a new error group for header errors
        ErrorGroup headerErrors = new ErrorGroup();

        // Regex to match Utility.ddd
        Pattern headerPattern = Pattern.compile("Utility\\.([a-zA-Z_]+)?(\\d{3})", Pattern.CASE_INSENSITIVE);

        // Reads the first line (headers of the csv file)
        List<String> rowHeaders = List.of(reader.readNext());
        sData.currentColumn = reader.getLinesRead();

        Map<Integer, Building> mappedHeaders = IntStream.range(0, rowHeaders.size())
                .boxed()
                .collect(Collectors.toMap(index -> index + 1, index -> {
                    // Gets value in list at current index
                    String listValue = rowHeaders.get(index);

                    sData.currentRow = index + 1;

                    // Runs regex on the header
                    Matcher match = headerPattern.matcher(listValue);
                    Building building = new Building();

                    if (match.find()) {

                        // Extracts digits
                        String buildingCode = match.group(2);

                        // Query db for building code
                        Optional<Building> queriedBuilding = buildingRepo.findById(buildingCode);

                        // Log error if we didn't find a building code
                        if (queriedBuilding.isEmpty()) {
                            String errorMessage = "Building code not found for building code " + buildingCode + " on " + listValue;
                            logger.error(errorMessage);
                            Error error = new Error(errorMessage, Error.Errors.NOBUILDING);
                            sData.setAddType(SheetData.addType.Column);
                            errorManager.addPropError(error);
                        } else {
                            building = queriedBuilding.get();
                        }
                        // Log error if regex did not find a match
                    } else {
                        String errorMessage = "Regex match failed for " + listValue;
                        logger.error(errorMessage);
                        Error error = new Error(errorMessage, Error.Errors.FAILEDREGEX);
                        sData.setAddType(SheetData.addType.Column);
                        errorManager.addPropError(error);
                    }
                    return building;
                }));
        // Adds errors if necessary
        //response.addErrorGroup(headerErrors);
        return mappedHeaders;
    }

    /**
     * Parses and validates timestamp
     * @param date - Date to parse
     * @param errorGroup - Error group to add to
     * @param dateColumn - index of the date column
     * @return - Timestamp
     */
    private Timestamp getTimestamp(String date, ErrorGroup errorGroup, long dateColumn) {
        Timestamp stamp = null;
        try {
            DateFormat format = new SimpleDateFormat("MM/dd/yy HH:mm");
            Date time = format.parse(date);
            stamp = new Timestamp(time.getTime());
        } catch (ParseException ex) {
            String errorMessage = "Failed to parse date " + date + " at row " + reader.getLinesRead() + " column " + dateColumn;
            logger.error(errorMessage);
            Error timestampError = new Error();
            timestampError.setErrorMessage(errorMessage, Error.Errors.DATEFORMAT);

            sData.setAddType(SheetData.addType.Row);
            errorManager.addPropError(timestampError);
        }
        return stamp;
    }

    /**
     * Reads the data from the csv
     * @return response object to send to client.
     * @throws CsvValidationException - Throws if csv is invalid
     * @throws IOException - Throws if IOException occurs
     */
    @Override
    public Response readData() throws CsvValidationException, IOException {

        // Get map to header
        Map<Integer, Building> headersMap = generateHeaderMap();
        final int DATE_COLUMN = 0;

        String[] rowData = null;

        // Read row by row
        while ((rowData = reader.readNext()) != null) {
            sData.currentRow = reader.getLinesRead();
            Usage usage = new Usage();

            // Date/timestamp is always at index 0
            String date = rowData[DATE_COLUMN];
            ErrorGroup errorGroup = new ErrorGroup();
            errorGroup.addGroupData(usage);
            Timestamp stamp = getTimestamp(date, errorGroup, DATE_COLUMN);

            // Read column by column starting after the date field
            for (int i = 1; i < rowData.length; i++) {
                sData.currentColumn = i + 1;
                usage.timestamp = stamp;
                Building building = headersMap.get(i);
                String buildingCode = building.buildingCode;
                usage.buildingCode = buildingCode;
                usage.utilityID = utilityID;

                // Skip the row if the building code is null.
                if (buildingCode != null && stamp != null) {
                    String data = rowData[i];
                    int currentColumn = i + 1;

                    // Skip empty or null columns
                    if (!data.equals("") && !data.equals("NULL")) {
                        try {
                            double utilityUsage = Double.parseDouble(data);
                            BigDecimal result = new BigDecimal(utilityUsage);
                            usage.utilityUsage = result;
                        } catch (NumberFormatException exception) {
                            String errorMessage = "Failed to parse usage to double " + data + " at row " + reader.getLinesRead() + " column " + currentColumn;
                            logger.error(errorMessage);
                            Error numberFormatError = new Error();
                            numberFormatError.setErrorMessage(errorMessage, Error.Errors.DATAFORMAT);
                            errorManager.addError(numberFormatError, usage);
                        }
                    } else {
                        logger.debug("Skipping data at row " + reader.getLinesRead() + " column " + currentColumn);
                    }

                    // Determines if there were errors in the group and adds them.
                   // boolean added = response.addErrorGroup(errorGroup);
                    //if (!added)
                        response.addSuccess(usage);
                        errorManager.setPropagation(usage);
                }
            }
        }

        // Calculates the summary in the response.
        response.calculateSummary();
        return response;
    }
}


