package ErrorManagement.CSV;

import ErrorManagement.Error;
import ErrorManagement.ErrorManager;
import application.Database.EnergyDB.Models.Usage;
import application.Model.Response;

import java.util.*;

public class SheetManager<T> extends ErrorManager<T> {

    // Keep track of propagating errors in the row direction
    private Map<Integer, List<Error<T>>> rowErrors;

    // Keeps track of propagating errors in the column direction
    private Map<Integer, List<Error<T>>> columnErrors;

    // Keeps track of atomic errors (only applies to a cell)
    private HashSet<Cell<String>> cellErrors;
    private Response response;

    public SheetManager(Response response) {
        rowErrors = new HashMap<>();
        columnErrors = new HashMap<>();
        cellErrors = new HashSet<>();
        this.response = response;
    }

    /**
     * Modifies a propagating map
     * @param map - Map to modify
     * @param index - index to update
     * @param errorToAdd - the error to add at that index
     */
    private void modifyMap(Map<Integer, List<Error<T>>> map, int index, Error<T> errorToAdd){
        List<Error<T>> list = new ArrayList<>();
        if(map.get(index) != null){
            list = map.get(index);
        }
        else{
            map.put(index, list);
        }
        list.add(errorToAdd);
    }

    @Override
    public void addError(Error<T> error) {
        // Ask child for what type of error data it has.
        SheetErrorData data = (SheetErrorData) error.getErrorData();
        Cell<String> errorCell = data.getCell();

        // Checks for propagating error if it is then we need to add it to be tracked
        if(data.doesPropagate()){
            SheetErrorData.Direction propDirection = data.direction();
            if(propDirection == SheetErrorData.Direction.COLUMN){
                modifyMap(columnErrors, errorCell.getColumn(), error);
            }
            else{
                modifyMap(rowErrors, errorCell.getRow(), error);
            }
        }

        // Add as an atomic error so we don't add this to a success.
        cellErrors.add(errorCell);

        // Adds error to the response
        response.addError(error);

        // Generates error message and logs it.
        String errorMessage = error.getErrorMessage() + " " + errorCell.toString();
        error.setErrorMessage(errorMessage);
        logger.error(errorMessage);
    }
    @Override
    public void addError(Error<T> error, T item) {
        // Get the error data from the child
        SheetErrorData data = (SheetErrorData) error.getErrorData();
        Cell<String> errorCell = data.getCell();

        // Checks for propagating error if it is then we need to add it to be tracked
        if(data.doesPropagate()){
            SheetErrorData.Direction propDirection = data.direction();
            if(propDirection == SheetErrorData.Direction.COLUMN){
                modifyMap(columnErrors, errorCell.getColumn(), error);
            }
            else{
                modifyMap(rowErrors, errorCell.getRow(), error);
            }
        }

        // Adds an item that was affected by the error.
        error.addItem(item);

        // Updates response and other book keeping data.
        response.addError(error);
        cellErrors.add(errorCell);
        String errorMessage = error.getErrorMessage() + " " + errorCell.toString();
        error.setErrorMessage(errorMessage);
        logger.error(errorMessage);
    }

    /**
     * Checks for any propagating errors that need to be applied.
     * @param rowIndex - Row to check for errors
     * @param columnIndex - column to check for errors
     * @param value - The usage value to check for errors
     */
    public void applyErrors(int rowIndex, int columnIndex, Usage value){
        boolean fail = false;
        Cell<String> cell = new Cell<>(rowIndex, columnIndex, "");
        if(columnErrors.get(columnIndex) != null){
            fail = true;
            List<Error<T>> columnError = columnErrors.get(columnIndex);
            for(Error error: columnError){
                error.addItem(value);
            }
        }
        if(rowErrors.get(rowIndex) != null){
            fail = true;
            List<Error<T>> rowErrorsList = rowErrors.get(rowIndex);
            for(Error error: rowErrorsList){
                error.addItem(value);
            }
        }
        if(cellErrors.contains(cell)){
            fail = true;
        }
        if(!fail){
            response.addSuccess(value);
        }
    }
}
