package application.CSV;

import application.Database.EnergyDB.Models.Usage;
import application.Datasource;
import application.Model.Response;

import java.io.FileNotFoundException;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;

public class SmallElectricPaser extends CsvParser {
    
    public SmallElectricPaser(String csvPath, int utilityID) throws FileNotFoundException {
        super(csvPath, utilityID);
    }

    @Override
    public Response readData() {
        return null;
    }
}
