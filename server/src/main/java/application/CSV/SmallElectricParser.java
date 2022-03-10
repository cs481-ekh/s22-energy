package application.CSV;

import application.Database.EnergyDB.Models.Building;
import application.Database.EnergyDB.Models.Usage;
import application.Database.EnergyDB.Repo.JPARepository.PremiseRepo;
import application.Model.Error;
import application.Model.ErrorGroup;
import application.Model.Response;
import com.opencsv.exceptions.CsvValidationException;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import static application.EnergyConverter.kWhToKbtu;


public class SmallElectricParser extends CsvParser {
    private final PremiseRepo premiseRepo;

    public SmallElectricParser(String csvPath, int utilityID, PremiseRepo repo) throws FileNotFoundException {
        super(csvPath,utilityID);
        this.premiseRepo = repo;
    }

    /**
     * Parses and validates timestamp
     * @param date - Date to parse
     * @param errorGroup - Error group to add to
     * @param dateColumn - index of the date column
     * @return - Timestamp
     */
    private Timestamp getTimestamp(String date, ErrorGroup errorGroup, int dateColumn) {
        Timestamp stamp = null;
        try {
            DateFormat format = new SimpleDateFormat("MM/dd/yy");
            Date time = format.parse(date);
            stamp = new Timestamp(time.getTime());
        } catch (ParseException ex) {
            String errorMessage = "Failed to parse date " + date + " at row " + reader.getLinesRead() + " column " + dateColumn;
            logger.error(errorMessage);
            Error timestampError = new Error();
            timestampError.setErrorMessage(errorMessage, Error.Errors.DATEFORMAT);
            errorGroup.addError(timestampError);
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
        Response response = new Response();
        ErrorGroup errorGroup = new ErrorGroup();
        HashMap<String, Integer> headerMap = new HashMap<>();

        String[] rowData = null;

        String[] header = reader.readNext();
        for(int i = 0; i < header.length ; i++) {
            headerMap.put(header[i].toLowerCase(), i);
        }

        if(headerMap.containsKey("premise#") && headerMap.containsKey("billperiodenddate") && headerMap.containsKey(
                "actualkw") && headerMap.containsKey("billamount")){

            while((rowData = reader.readNext()) != null) {
                Usage usage = new Usage();
                errorGroup.setUsage(usage);
                Timestamp endDate = null;
                String date = null;

                Integer premiseColNum = headerMap.get("premise#");
                long premiseCode = Long.parseLong(rowData[premiseColNum]);

                //Queries database to retrieve building code using premise number
                Optional<Building> queryPremise = premiseRepo.getPremiseBuilding(premiseCode);
                if (queryPremise.isEmpty()) {
                    String errorMessage = "Building code does not exist for premise: " + premiseCode;
                    logger.error(errorMessage);
                    Error error = new Error(errorMessage, Error.Errors.NOBUILDING);
                    errorGroup.addError(error);
                    response.addErrorGroup(errorGroup);
                }else {
                    usage.buildingCode = queryPremise.get().buildingCode;
                    Integer dateColNum = headerMap.get("billperiodenddate");
                    endDate = getTimestamp(rowData[dateColNum], errorGroup, dateColNum);
                    usage.timestamp = endDate;
                    Integer usageColNum = headerMap.get("actualkw");
                    double smallUsage = Double.parseDouble(rowData[usageColNum]);
                    BigDecimal usageKbtu = new BigDecimal(kWhToKbtu(smallUsage));
                    usage.utilityUsage = usageKbtu;
                    Integer billColNum = headerMap.get("billamount");
                    BigDecimal cost = new BigDecimal(rowData[billColNum]);
                    usage.cost = cost;
                    usage.utilityID = utilityID;

                    // add Aidan's Validation check for nulls or empty strings
                    response.addSuccess(usage);
                }
            }
        }else{
            String errorMessage = "File header format incorrect";
            logger.error(errorMessage);
            Error error = new Error(errorMessage, Error.Errors.FAILEDREGEX);
            errorGroup.addError(error);
            response.addErrorGroup(errorGroup);
        }
        return response;
    }

}
