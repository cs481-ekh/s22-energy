package application.CSV;

import application.Database.EnergyDB.Models.Building;
import application.Database.EnergyDB.Models.Usage;
import application.Database.EnergyDB.Repo.JPARepository.BuildingRepo;
import application.Model.Error;
import application.Model.ErrorGroup;
import application.Model.Response;
import com.opencsv.exceptions.CsvValidationException;
//import jdk.internal.jimage.BasicImageReader;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class SmallElectricParser extends CsvParser {
    private final BuildingRepo buildingRepo;

    public SmallElectricParser(String csvPath, int utilityID, BuildingRepo repo) throws FileNotFoundException {
        super(csvPath,utilityID);
        this.buildingRepo = repo;
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
        String[] rowData = null;

        // Validate header
        String[] headerLine = new String[]{"brian","BPName","Account#","Contract#","ContractStartDt","ContractEndDt",
                "Rate","Premise#","PremiseAddress","UsageMonth","Invoice#","Bill#","BillPeriodStartDate",
                "BillPeriodEndDate","BillPeriodDays","BillAmount","kWhQty","BilledkW","ActualkW","BLC","Meter#"};
        List<String> expectedHeaders = Arrays.asList(headerLine);
        String[] header = reader.readNext();
        if (!Arrays.asList(header).containsAll(expectedHeaders)){
            String errorMessage = "Incorrect header format";
            logger.error(errorMessage);
            response.addErrorGroup(errorGroup);
            System.exit(0);
        }
        while((rowData = reader.readNext()) != null){
            Usage usage = new Usage();
            errorGroup.setUsage(usage);
            Timestamp endDate = null;
            String date = rowData[13]; // column date
            final BigDecimal smallUsage = new BigDecimal(rowData[17]);
            if(date != null || date!= ""){
                endDate = getTimestamp(date, errorGroup, 17);
                usage.timestamp = endDate;
            }else {
                String errorMessage = "Row " + reader.getLinesRead() + ": column 13";
                logger.error(errorMessage);
            }
            if(smallUsage != null || smallUsage.compareTo(BigDecimal.ZERO) != 0) {
                usage.utilityUsage = smallUsage;
            }else{
                String errorMessage = "Row " + reader.getLinesRead() + ": column 17";
                logger.error(errorMessage);
            }
            usage.utilityID = utilityID;

            boolean added = response.addErrorGroup(errorGroup);
            if (!added)
                response.addSuccess(usage);

        }
        return null;
    }

}
