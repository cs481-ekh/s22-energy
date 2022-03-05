package application;

import application.Model.Response;
import com.opencsv.exceptions.CsvValidationException;

import java.io.IOException;

/**
 * Interface for reading from a data source.
 */
public interface Datasource {
    /**
     * Reads from the data source
     * EX: CSV will read from file
     */
    Response readData() throws CsvValidationException, IOException;
}
