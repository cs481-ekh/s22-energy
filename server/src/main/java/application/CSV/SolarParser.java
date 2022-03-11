package application.CSV;

import application.Database.EnergyDB.Models.Building;
import application.Database.EnergyDB.Models.Usage;
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

public class SolarParser extends CsvParser {

    public SolarParser(String csvPath, int utilityID) throws FileNotFoundException {
        super(csvPath, utilityID);
    }

    @Override
    protected Timestamp getTimestamp(String date, ErrorGroup errorGroup, int dateColumn) {
        Timestamp stamp = null;
        try {
            DateFormat format = new SimpleDateFormat("dd/MM/yyyy");
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
        final int DATE = 0;
        final int ENERGY = 3;
        // solar has no dollar amount associated with it

        // skip the header lines
        reader.readNext();
        reader.readNext();

        // iterate through the csv grabbing rows and parsing them into usage objects
        String[] row;
        while ((row = reader.readNext()) != null) {
            var usage = new Usage();
            errorGroup.setUsage(usage);
            boolean successfulRow = true;

            // grab the date from the row, parse it, and add it to the usage object
            try {
                usage.timestamp = getTimestamp(row[DATE], errorGroup, DATE);
            } catch (Exception e) {
                String errorMessage = "Failed to parse Date on row " + reader.getLinesRead();
                logger.error(errorMessage);
                errorGroup.addError(new Error(errorMessage, Error.Errors.DATEFORMAT));
                successfulRow = false;
            }

            // grab the kWh-generated from the row
            double kWh = -1;
            try {
                kWh = Double.parseDouble(row[ENERGY]);
            } catch (Exception e) {
                String errorMessage = "Failed to parse Total System kWh on row " + reader.getLinesRead();
                logger.error(errorMessage);
                errorGroup.addError(new Error(errorMessage, Error.Errors.DATAFORMAT));
                successfulRow = false;
            }

            // convert the therms (if we got them) to kBTU and add them to the usage object
            if (kWh > -1) {
                try {
                    double kBTU = EnergyConverter.thermsToKbtu(kWh);
                    usage.utilityUsage = new BigDecimal(EnergyConverter.doubleToString(kBTU));
                } catch (Exception e) {
                    String errorMessage = "Failed to convert kWh to kBTU on row " + reader.getLinesRead();
                    logger.error(errorMessage);
                    errorGroup.addError(new Error(errorMessage, Error.Errors.DATAFORMAT));
                    successfulRow = false;
                }
            }

            // check for row success and store it appropriately
            if (successfulRow)
                response.addSuccess(usage);
            else
                response.addErrorGroup(errorGroup);

        }
        return response;
    }
}
