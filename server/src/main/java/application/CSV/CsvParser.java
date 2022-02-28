package application.CSV;

import application.Database.EnergyDB.Models.Usage;
import application.Model.Response;

import java.io.File;

public abstract class CsvParser {

    private Response repsonse;
    private File csvFile;

    public CsvParser(String csvPath){
        csvFile = new File(csvPath);

    }
    // pulbic asbstract void upload(array list) - will take in list from smallelectic
    public abstract Response parse();

    // getter & setter

    public void setRepsonse(Response repsonse) {
        this.repsonse = repsonse;
    }

    public Response getRepsonse() {
        return repsonse;
    }

    public File getCsvFile() {
        return csvFile;
    }
}
