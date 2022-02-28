package application.CSV;

import application.Database.EnergyDB.Models.Usage;
import application.Model.Response;

import java.sql.Timestamp;
import java.time.Instant;

public class SmallElectricPaser extends CsvParser{
    
    public SmallElectricPaser(String csvPath) {
        super(csvPath);
    }

    @Override
    public Response parse() {
        Usage initUsage = new Usage();
        initUsage.timestamp = Timestamp.from(Instant.now()); // Change startdate actual value from CSV parse
        Usage currUsage = new Usage();
        initUsage.timestamp = Timestamp.from(Instant.now()); // Change enddate actual valeu from CSV parse
        Usage summaryUsage = new Usage();
        //increment summaryUsage as you read csv

        //Query database to get premise id && any errors go to errors list
        //Query database to get building code && any errors go to errors list
        //Another array list under parse that holds all the usages built
        //create method called upload csv Pass to csvparser - only if no errors
        //read all csv's to parse data
        return null; //just so it clears errors, change later
    }
}
