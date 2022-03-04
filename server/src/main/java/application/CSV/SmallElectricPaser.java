package application.CSV;

import application.Database.EnergyDB.Models.Usage;
import application.Datasource;
import application.Model.Response;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;

public class SmallElectricPaser extends CsvParser {
    
    public SmallElectricPaser(String csvPath) {
        super(csvPath);
    }

    @Override
    public Response readData() {
        return null;
    }
}
