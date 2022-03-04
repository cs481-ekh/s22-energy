package application;

import application.Model.Response;

/**
 * Interface for reading from a data source.
 */
public interface Datasource {
    /**
     * Reads from the data source
     * EX: CSV will read from file
     */
    Response readData();
}
