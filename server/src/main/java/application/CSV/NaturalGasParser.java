package application.CSV;

import application.Database.EnergyDB.Models.Building;
import application.Database.EnergyDB.Models.Usage;
import application.Database.EnergyDB.Repo.JPARepository.BuildingRepo;
import application.Database.EnergyDB.Repo.JPARepository.PremiseRepo;
import application.EnergyConverter;
import application.Model.Error;
import application.Model.ErrorGroup;
import application.Model.Response;
import com.opencsv.exceptions.CsvValidationException;
import org.springframework.boot.autoconfigure.info.ProjectInfoProperties;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Optional;

public class NaturalGasParser extends CsvParser {
    private final PremiseRepo premiseRepo;

    public NaturalGasParser(String csvPath, int utilityID, PremiseRepo repo) throws FileNotFoundException {
        super(csvPath, utilityID);
        this.premiseRepo = repo;
    }

    @Override
    protected Timestamp getTimestamp(String date, ErrorGroup errorGroup, int dateColumn) {
        Timestamp stamp = null;
        try {
            DateFormat format = new SimpleDateFormat("dd-MMMM-yy");
            stamp = new Timestamp(format.parse(date).getTime());
        } catch (ParseException e) {
            String errorMessage = "Failed to parse date " + date + " at row " + reader.getLinesRead() + " column " + dateColumn;
            logger.error(errorMessage);
            Error timestampError = new Error();
            timestampError.setErrorMessage(errorMessage, Error.Errors.DATEFORMAT);
            errorGroup.addError(timestampError);
        }
        return stamp;
    }

    @Override
    public Response readData() throws CsvValidationException, IOException {
        var response = new Response();
        var errorGroup = new ErrorGroup();

        // get the index for each of the columns we care about (assuming the columns will always be in the same order...)
        final int PREMISE = 2;
        final int DATE = 5;
        final int COST = 7;
        final int ENERGY = 8;

        // skip the header line
        reader.readNext();

        // iterate through the csv grabbing rows and parsing them into usage objects
        String[] row;
        boolean successfulRow = true;
        while ((row = reader.readNext()) != null) {
            var usage = new Usage();
            errorGroup.setUsage(usage);

            // grab the date from the row, parse it, and add it to the usage object
            try {
                usage.timestamp = getTimestamp(row[DATE], errorGroup, DATE);
            } catch (Exception e) {
                String errorMessage = "Failed to parse MeterEndDate on row " + reader.getLinesRead();
                logger.error(errorMessage);
                errorGroup.addError(new Error(errorMessage, Error.Errors.DATEFORMAT));
                response.addErrorGroup(errorGroup);
                successfulRow = false;
            }

            // grab the cost from the row and add it to the usage object
            try {
                usage.cost = new BigDecimal(row[COST]);
            } catch (Exception e) {
                String errorMessage = "Failed to parse CurrentGasCharges on row " + reader.getLinesRead();
                logger.error(errorMessage);
                errorGroup.addError(new Error(errorMessage, Error.Errors.DATAFORMAT));
                response.addErrorGroup(errorGroup);
                successfulRow = false;
            }

            // grab the therms-expended from the row
            double therms = -1;
            try {
                therms = Double.parseDouble(row[ENERGY]);
            } catch (Exception e) {
                String errorMessage = "Failed to parse ThermsBilled on row " + reader.getLinesRead();
                logger.error(errorMessage);
                errorGroup.addError(new Error(errorMessage, Error.Errors.DATAFORMAT));
                response.addErrorGroup(errorGroup);
                successfulRow = false;
            }

            // convert the therms (if we got them) to kBTU and add them to the usage object
            if (therms > -1) {
                try {
                    String kBTU = EnergyConverter.thermsToKbtu(therms);
                    usage.utilityUsage = new BigDecimal(kBTU);
                } catch (Exception e) {
                    String errorMessage = "Failed to convert therms to kBTU on row " + reader.getLinesRead();
                    logger.error(errorMessage);
                    errorGroup.addError(new Error(errorMessage, Error.Errors.DATAFORMAT));
                    response.addErrorGroup(errorGroup);
                    successfulRow = false;
                }
            }

            // grab the premise_id from the row
            long premiseId = -1;
            try {
                premiseId = Long.parseLong(row[PREMISE]);
            } catch (Exception e) {
                String errorMessage = "Failed to parse PremiseID on row " + reader.getLinesRead();
                logger.error(errorMessage);
                errorGroup.addError(new Error(errorMessage, Error.Errors.MISSINGPREMISE));
                response.addErrorGroup(errorGroup);
                successfulRow = false;
            }

            // query the db for the building code using the premise id (if we got one)
            if (premiseId > 0) {
                Optional<Building> queryPremise = premiseRepo.getPremiseBuilding(premiseId);

                // verify we got a non-null response or report an error
                if (queryPremise.isEmpty()) {
                    String errorMessage = "Building code does not exist for premise: " + premiseId;
                    logger.error(errorMessage);
                    errorGroup.addError(new Error(errorMessage, Error.Errors.NOBUILDING));
                    response.addErrorGroup(errorGroup);
                    successfulRow = false;
                } else {
                    // assign the building code to the usage object
                    usage.buildingCode = queryPremise.get().buildingCode;
                }
            }




        }
        return null;
    }
}
