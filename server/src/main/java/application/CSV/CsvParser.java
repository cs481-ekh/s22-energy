package application.CSV;

import ErrorManagement.CSV.Sheet;
import ErrorManagement.ErrorManager;
import application.Database.EnergyDB.Models.Usage;
import application.Datasource;
import application.Model.Response;
import com.opencsv.CSVReader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.nio.file.InvalidPathException;
import java.nio.file.Paths;

public abstract class CsvParser implements Datasource {

    protected Response response;
    private final File csvFile;
    protected int utilityID;
    protected ErrorManager<SheetData, Usage> errorManager;
    protected SheetData sData;

    final transient Logger logger = LoggerFactory.getLogger(getClass());
    protected final CSVReader reader;

    /**
     * Creates a new CSV parser
     * @param csvPath - Path to the csv file
     * @param utilityID - The utility id the csv is parsing
     * @throws InvalidPathException - If csv path is invalid
     * @throws FileNotFoundException - If file is not found.
     */
    public CsvParser(String csvPath, int utilityID) throws InvalidPathException, FileNotFoundException {
        // Validates the path, throws an exception if false
        Paths.get(csvPath);
        csvFile = new File(csvPath);
        sData = new SheetData(0, 0);

        // Creates new file reader
        FileReader fileReader = new FileReader(csvFile);

        // Creates openCSV reader
        reader = new CSVReader(fileReader);
        response = new Response();
        this.utilityID = utilityID;
        errorManager = new Sheet();
        errorManager.setManagerData(sData);
    }

    /**
     * Sets the response to a new reference
     * @param repsonse - Response to change to.
     */
    public void setRepsonse(Response repsonse) {
        this.response = repsonse;
    }

    /**
     * Gets the response object.
     * @return - Response object.
     */
    public Response getRepsonse() {
        return response;
    }

    /**
     * The File object for the csv file
     * @return - Java file representation of the CSV file
     */
    public File getCsvFile() {
        return csvFile;
    }
}
