package application.CSV;
import ErrorManagement.CSV.SheetErrorData;
import ErrorManagement.SheetValidator;
import application.Database.EnergyDB.Models.Building;
import application.Database.EnergyDB.Models.Usage;
import application.Database.EnergyDB.Repo.JPARepository.BuildingRepo;
import application.Model.ErrorGroup;
import application.Model.Response;
import com.opencsv.exceptions.CsvValidationException;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import application.Database.EnergyDB.Repo.JPARepository.BuildingRepo;

import static application.EnergyConverter.btuToKbtu;

public class GeoThermalParser extends CsvParser{
    private final BuildingRepo buildingRepo;

    public GeoThermalParser(String csvPath, int utilityID, BuildingRepo repo) throws FileNotFoundException {
        super(csvPath, utilityID);
        buildingRepo = repo;
    }

    private Timestamp getTimestamp(String date, ErrorGroup errorGroup) {
        Timestamp stamp = null;
        try {
            DateFormat format = new SimpleDateFormat("MM/dd/yy");
            Date time = format.parse(date);
            stamp = new Timestamp(time.getTime());
        } catch (ParseException ex) {
            String errorMessage = "Failed to parse date " + date + " at row " + reader.getLinesRead() + " column ";
            java.lang.Error timestampError = new Error();
            errorGroup.addError(timestampError);
        }
        return stamp;
    }

    /**
     * @return response object to send to client.
     * @throws CsvValidationException - Throws if csv is invalid
     * @throws IOException            - Throws if IOException occurs
     */
    @Override
    public Response readData() throws CsvValidationException, IOException {
        HashMap<String, Integer> headerMap = new HashMap<>();
        String[] rowData = null;
        ErrorGroup errorGroup = new ErrorGroup();
        String dateInString =new SimpleDateFormat("MM/dd/yy").format(new Date());

        // Reads 1st line of file to parse header values
        String[] header = reader.readNext();
        for(int i = 0; i < header.length ; i++) {
            headerMap.put(header[i].toLowerCase(), i);
        }

        if(headerMap.containsKey("bldg #") && headerMap.containsKey("bldg name") && headerMap.containsKey(
                "btu") && headerMap.containsKey("gal")){

            while((rowData = reader.readNext()) != null) {
                Usage usage = new Usage();
                errorGroup.setUsage(usage);
                Timestamp endDate = null;
                String date = null;
                DecimalFormat df = new DecimalFormat("000");
                String buildingCode = rowData[headerMap.get("bldg #")];
                if(buildingCode.length() < 3){
                    int len = buildingCode.length();
                    buildingCode = "000".substring(len)+buildingCode;
                }

                //Queries database to retrieve building code using premise number
                Optional<Building> queryBuilding = buildingRepo.getBuildingByCode(buildingCode);
                if (queryBuilding.isEmpty()) {
                    String errorMessage = "Building code does not exist: " + buildingCode;
                }else {
                    usage.buildingCode = queryBuilding.get().buildingCode;
                    endDate = getTimestamp(dateInString, errorGroup);
                    usage.timestamp = endDate;
                    Integer usageColNum = Integer.valueOf(headerMap.get("gal"));
                    String value = rowData[usageColNum].replaceAll("[\\s+,]","");
                    BigDecimal smallUsage = new BigDecimal(value);
                    //YOU NEED TO CHANGE smallUsage to a decimal
                    BigDecimal BTU = new BigDecimal(rowData[headerMap.get("btu")]);
                    BigDecimal usageKbtu = btuToKbtu(BTU);
                    usage.utilityUsage = usageKbtu;
                    // NO COST in the GeoThermal table, set cost to zero
//                    Integer billColNum = headerMap.get("billamount");
                    BigDecimal cost = new BigDecimal(0);
                    usage.cost = cost;
                    usage.utilityID = utilityID;

                    // add Aidan's Validation check for nulls or empty strings
                    response.addSuccess(usage);
                }
            }
        }else{
            String errorMessage = "File header format incorrect";
        }
        return response;
    }
}
