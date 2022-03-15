package application.CSV;

import ErrorManagement.CSV.SheetManager;
import ErrorManagement.SheetValidator;
import application.Database.EnergyDB.Models.Usage;
import application.Datasource;
import application.Model.Response;
import com.opencsv.CSVReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.nio.file.InvalidPathException;
import java.nio.file.Paths;

public abstract class CsvParser implements Datasource {
    private final File csvFile;
    protected int utilityID;
    protected SheetValidator<Usage> sheetValidator;
    protected SheetManager<Usage> manager;
    protected final CSVReader reader;
    protected Response response;

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

        // Creates new file reader
        FileReader fileReader = new FileReader(csvFile);

        // Creates openCSV reader
        reader = new CSVReader(fileReader);
        response = new Response();
        this.utilityID = utilityID;
        manager = new SheetManager<>(response);
        sheetValidator = new SheetValidator(manager);
    }


    /**
     * The File object for the csv file
     * @return - Java file representation of the CSV file
     */
    public File getCsvFile() {
        return csvFile;
    }
}
