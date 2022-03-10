package application.CSV;

import application.Database.EnergyDB.Models.Usage;
import application.Datasource;
import application.Model.ErrorGroup;
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
import java.sql.Timestamp;

public abstract class CsvParser implements Datasource {

    protected Response response;
    private final File csvFile;
    protected int utilityID;

    final transient Logger logger = LoggerFactory.getLogger(getClass());
    protected final CSVReader reader;

    /**
     * Creates a new CSV parser
     *
     * @param csvPath   - Path to the csv file
     * @param utilityID - The utility id the csv is parsing
     * @throws InvalidPathException  - If csv path is invalid
     * @throws FileNotFoundException - If file is not found.
     */
    public CsvParser(String csvPath, int utilityID) throws InvalidPathException, FileNotFoundException {
        // Validates the path, throws an exception if false
        Paths.get(csvPath);
        csvFile = new File(csvPath);

        // Creates new file reader
        FileReader fileReader = new FileReader(csvFile);

        // Creates openCSV reader
        reader = new CSVReader(fileReader);
        response = new Response();
        this.utilityID = utilityID;
    }

    /**
     * Sets the response to a new reference
     *
     * @param repsonse - Response to change to.
     */
    public void setRepsonse(Response repsonse) {
        this.response = repsonse;
    }

    /**
     * Gets the response object.
     *
     * @return - Response object.
     */
    public Response getRepsonse() {
        return response;
    }

    /**
     * The File object for the csv file
     *
     * @return - Java file representation of the CSV file
     */
    public File getCsvFile() {
        return csvFile;
    }

    /**
     * Convert the csv's timestamp string to a sql timestamp object
     *
     * @return - sql Timestamp object
     */
    protected abstract Timestamp getTimestamp(String date, ErrorGroup errorGroup, int dateColumn);

}