package ErrorManagement;

import ErrorManagement.CSV.SheetManager;
import ErrorManagement.ErrorTypes.ErrorType;

import java.util.ArrayList;
import java.util.List;

/**
 * Defines a base error
 * @param <T> - Error data if any to hold reference to
 */
public abstract class Error<T> {
    private ErrorType errorType;
    private List<T> items;
    private String message;
    protected ErrorData errorData;

    public Error(ErrorType type){
        items = new ArrayList<>();
        errorType = type;
    }

    /**
     * Adds an item to an error
     * @param item - item to add
     */
    public void addItem(T item){
        items.add(item);
    }

    /**
     * Returns the list of items referenced by an error.
     * @return list of items
     */
    public List<T> getItems() {
        return items;
    }

    /**
     * Gets data related to an error (used in bookkeeping).
     * @return the associated error data
     */
    public ErrorData getErrorData(){
        return errorData;
    }

    /**
     * Gets error message for this error.
     * @return
     */
    public String getErrorMessage(){
         return errorType.generateErrorMessage();
    }

    /**
     * Sets the error message for the error
     * @param message - Message to set the error to.
     */
    public void setErrorMessage(String message){
        this.message = message;
    }

    /**
     * Gets the severity of the error.
     * @return - Severity of error
     */
    public  ErrorType.Severity getSeverity(){
        return errorType.getSeverity();
    }
}