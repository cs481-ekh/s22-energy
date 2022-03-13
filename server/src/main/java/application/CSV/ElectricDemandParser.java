package application.CSV;

import ErrorManagement.CSV.SheetErrorData;
import ErrorManagement.SheetValidator;
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
        // Regex to match Utility.ddd
        Pattern headerPattern = Pattern.compile("Utility\\.([a-zA-Z_]+)?(\\d{3})", Pattern.CASE_INSENSITIVE);

        // Reads the first line (headers of the csv file)
        List<String> rowHeaders = List.of(reader.readNext());
        final int HEADER_ROW = 0;

        Map<Integer, Building> mappedHeaders = IntStream.range(0, rowHeaders.size())
                .boxed()
                .collect(Collectors.toMap(index -> index + 1, index -> {
                    // Gets value in list at current index
                    String listValue = rowHeaders.get(index);

                    // Runs regex on the header
                    Matcher match = sheetValidator.validateRegex(HEADER_ROW, index + 1, listValue, headerPattern);
                    Building building = new Building();

                    if (match.find()) {
                        // Extracts digits
                        String buildingCode = match.group(2);

                        // Query db for building code
                        Optional<Building> queriedBuilding = buildingRepo.findById(buildingCode);

                        // Error handling on a failed building code
                        if (queriedBuilding.isEmpty()) {
                            sheetValidator.handleFailedBuildingCode(HEADER_ROW, index + 1, buildingCode, listValue, SheetErrorData.Direction.COLUMN);

                        } else {
                            building = queriedBuilding.get();
                        }
                    }
                    return building;
                }));

        return mappedHeaders;
    }

    /**
     * Reads the data from the csv
     *
     * @return response object to send to client.
     * @throws CsvValidationException - Throws if csv is invalid
     * @throws IOException            - Throws if IOException occurs
     */
    @Override
    public Response readData() throws CsvValidationException, IOException {
        // Get map to header
        Map<Integer, Building> headersMap = generateHeaderMap();
        final int DATE_COLUMN = 0;
        String[] rowData = null;

        // Read row by row
        while ((rowData = reader.readNext()) != null) {
            Usage usage = new Usage();
            int lines = (int) reader.getLinesRead();

            // Date/timestamp is always at index 0
            String date = rowData[DATE_COLUMN];
            DateFormat format = new SimpleDateFormat("MM/dd/yy");
            Timestamp stamp = sheetValidator.validateTimestamp(lines, DATE_COLUMN + 1, format, date, usage, SheetErrorData.Direction.ROW);

            // Read column by column starting after the date field
            for (int i = 1; i < rowData.length; i++) {
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
                        Double utilityUsage = sheetValidator.validateDouble(lines, currentColumn, data, usage);
                        BigDecimal result = new BigDecimal(utilityUsage);
                        usage.utilityUsage = result;
                    }
                    manager.applyErrors(lines, currentColumn, usage);
                }
            }
        }

        // Calculates the summary in the response.
        response.calculateSummary();
        return response;
    }
}


