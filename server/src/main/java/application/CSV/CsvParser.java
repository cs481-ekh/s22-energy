package application.CSV;

import application.Database.EnergyDB.Models.Usage;
import application.Datasource;
import application.Model.Response;
import application.Server;
import com.opencsv.CSVReader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.nio.file.InvalidPathException;
import java.nio.file.Paths;

public abstract class CsvParser implements Datasource {

    private Response repsonse;
    private File csvFile;
    protected int lineNumber;

    @Autowired
    final transient Logger logger = LoggerFactory.getLogger(getClass());
    protected CSVReader reader;

    public CsvParser(String csvPath) throws InvalidPathException, FileNotFoundException {
        // Validates the path, throws an exception if false
        Paths.get(csvPath);
        csvFile = new File(csvPath);
        FileReader fileReader = new FileReader(csvFile);
        reader = new CSVReader(fileReader);
        lineNumber = 0;
    }
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
