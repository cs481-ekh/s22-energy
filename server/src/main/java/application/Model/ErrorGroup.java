package application.Model;

import application.Database.EnergyDB.Models.Usage;

import java.util.ArrayList;
import java.util.List;

/**
 * Used for grouping errors to a particular usage object
 */
public class ErrorGroup {
    private List<Error> internalList;
    private Usage usage;

    /**
     * Creates and initializes error group.
     */
    public ErrorGroup(){
        internalList = new ArrayList<>();
    }

    /**
     * Adds an error to the group.
     * @param error - Error to add
     */
    public void addError(Error error){
        internalList.add(error);
    }

    /**
     * Sets the usage value
     * @param usage - Usage to associate error with.
     */
    public void setUsage(Usage usage){
        this.usage = usage;
    }

    /**
     * Gets the error count of the group.
     * @return number of errors in group.
     */
    public int getErrorCount(){
        return internalList.size();
    }
}
