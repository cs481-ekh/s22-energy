package application.CSV;

import application.Database.EnergyDB.Models.Usage;
import application.Database.EnergyDB.Repo.JPARepository.BuildingRepo;
import application.Model.ErrorGroup;
import application.Model.Response;
import com.opencsv.exceptions.CsvValidationException;
import org.springframework.boot.autoconfigure.info.ProjectInfoProperties;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Timestamp;

public class NaturalGasParser extends CsvParser {
    private final BuildingRepo buildingRepo;

    public NaturalGasParser(String csvPath, int utilityID, BuildingRepo repo) throws FileNotFoundException {
        super(csvPath, utilityID);
        this.buildingRepo = repo;
    }

    @Override
    protected Timestamp getTimestamp(String date, ErrorGroup errorGroup, int dateColumn) {
        return null;
    }

    // header column names and indeces
    enum cols {
        BILL_ID,
        ACCOUNT_ID,
        PREMISE_ID,
        SERVICE_AGREEMENT_ID,
        METER_START_DATE,
        METER_END_DATE,
        BILLING_DAYS,
        CURRENT_GAS_CHARGES,
        THERMS_BILLED
    }



    @Override
    public Response readData() throws CsvValidationException, IOException {
        var response = new Response();
        var errors = new ErrorGroup();
        String[] row;

        //skip the header
        reader.readNext();

        // iterate through the csv grabbing rows and parsing them into usage obejcts
        while ((row = reader.readNext()) != null) {
            var usage = new Usage();
            errors.setUsage(usage);

        }
        return null;
    }
}
