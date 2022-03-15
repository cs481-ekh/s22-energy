package ErrorManagement;

import ErrorManagement.CSV.Cell;
import ErrorManagement.CSV.SheetError;
import ErrorManagement.CSV.SheetErrorData;
import ErrorManagement.ErrorTypes.*;
import application.Model.Response;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Manages validation for a sheet.
 * @param <T> - Type of data we are storing from the sheet
 */
public class SheetValidator<T> {
    private ErrorManager<T> manager;

    public SheetValidator(ErrorManager<T> manager){
        this.manager = manager;
    }

    /**
     * Validates and returns a double, if fails returns null and error manager handles the rest.
     * @param row - row of the cell we are validating
     * @param column - column of the cell that we are validating
     * @param valueToConvert - The value to convert to a double
     * @param item - Item we are storing in the error.
     * @return - double if parse was successful, null otherwise
     */
    public Double validateDouble(int row, int column, String valueToConvert, T item){
        String dataType = "double";
        Double result = null;
        try{
            result = Double.parseDouble(valueToConvert);
        }
        catch (Exception ex){
            ErrorType type = new DataValidationError(ErrorType.Severity.WARNING, valueToConvert, dataType);
            Cell<String> errorCell = new Cell<>(row, column, valueToConvert);
            Error<T> validationError = new SheetError<T>(errorCell, type);
            manager.addError(validationError, item);
        }
        return result;
    }

    /**
     * Validates and returns a integer, if fails returns null and error manager handles the rest.
     * @param row - row of the cell we are validating
     * @param column - column of the cell that we are validating
     * @param valueToConvert - The value to convert to a integer
     * @param item - Item we are storing in the error.
     * @return - integer if parse was successful, null otherwise
     */
    public Integer validateInt(int row, int column, String valueToConvert, T item){
        String dataType = "integer";
        Integer result = null;
        try{
            result = Integer.parseInt(valueToConvert);
        }
        catch (Exception ex){
            ErrorType type = new DataValidationError(ErrorType.Severity.WARNING, valueToConvert, dataType);
            Cell<String> errorCell = new Cell<>(row, column, valueToConvert);
            Error<T> validationError = new SheetError<T>(errorCell, type);
            manager.addError(validationError, item);
        }
        return result;
    }

    /**
     * Will implement after talking with Victor/Taylor
     */
    public void validateHeader(){

    }

    /**
     * Validates that a regex expression works
     * @param row - row of the cell we are validating
     * @param column - column of the cell that we are validating
     * @param matchItem - The item we are trying to match the regex on
     * @param regex - The regex pattern to use
     * @return - The regex match
     */
    public Matcher validateRegex(int row, int column, String matchItem, Pattern regex){
        Matcher match = regex.matcher(matchItem);
        if(!match.find()){
            ErrorType type = new RegexFailedError(ErrorType.Severity.CRITICAL, regex.toString());
            Cell<String> errorCell = new Cell<>(row, column, matchItem);
            Error<T> regexError = new SheetError<T>(errorCell, type, true, SheetErrorData.Direction.COLUMN);
            manager.addError(regexError);
        }

        // Resets match since the match is incremented when we do match.find()
        return match.reset();
    }

    /**
     * Error handler when a premise fails to be found
     * @param row - row of the cell we are validating
     * @param column - column of the cell that we are validating
     * @param premiseID - The premise id that was not found.
     * @param value - The value that was in the cell.
     */
    public void handleFailedPremise(int row, int column, Long premiseID, String value){
        ErrorType type = new NoPremiseError(ErrorType.Severity.CRITICAL, premiseID.toString());
        Cell<String> errorCell = new Cell<>(row, column, value);
        Error<T> premiseError = new SheetError<T>(errorCell, type);
        manager.addError(premiseError);
    }

    /**
     * Error handler when a premise fails to be found
     * @param row - row of the cell we are validating
     * @param column - column of the cell that we are validating
     * @param premiseID - The premise id that was not found.
     * @param value - The value that was in the cell.
     * @param direction - The direction in which the propagating error applies (row, or column)
     */
    public void handleFailedPremise(int row, int column, Long premiseID, String value, SheetErrorData.Direction direction){
        ErrorType type = new NoPremiseError(ErrorType.Severity.CRITICAL, premiseID.toString());
        Cell<String> errorCell = new Cell<>(row, column, value);
        Error<T> premiseError = new SheetError<T>(errorCell, type, true, direction);
        manager.addError(premiseError);
    }

    /**
     * Error handler for when a building code fails to be found.
     * @param row - row of the cell we are validating
     * @param column - column of the cell that we are validating
     * @param buildingCode - The building code that was not found.
     * @param value - The value that was in the cell.
     */
    public void handleFailedBuildingCode(int row, int column, String buildingCode, String value){
        ErrorType type = new NoBuildingCodeError(ErrorType.Severity.CRITICAL, buildingCode);
        Cell<String> errorCell = new Cell<>(row, column, value);
        Error<T> buildingCodeError = new SheetError<T>(errorCell, type);
        manager.addError(buildingCodeError);
    }

    /**
     * Error handler for when a building code fails to be found.
     * @param row - row of the cell we are validating
     * @param column - column of the cell that we are validating
     * @param buildingCode - The building code that was not found.
     * @param value - The value that was in the cell.
     * @param direction - The direction that the propagating error should be applied (row or column)
     */
    public void handleFailedBuildingCode(int row, int column, String buildingCode, String value, SheetErrorData.Direction direction){
        ErrorType type = new NoBuildingCodeError(ErrorType.Severity.CRITICAL, buildingCode);
        Cell<String> errorCell = new Cell<>(row, column, value);
        Error<T> buildingCodeError = new SheetError<T>(errorCell, type, true, direction);
        manager.addError(buildingCodeError);
    }

    /**
     * Parses and validates the timestamp
     * @param row - row of the cell we are validating
     * @param column - column of the cell that we are validating
     * @param format - The date format to parse the string
     * @param date - The string representation of the date
     * @param item - Item to add to the error.
     * @return If parse was successful returns timestamp otherwise returns null.
     */
    public Timestamp validateTimestamp(int row, int column, DateFormat format, String date, T item) {
        Timestamp stamp = null;
        try {
            Date time = format.parse(date);
            stamp = new Timestamp(time.getTime());
        } catch (ParseException ex) {
            ErrorType type = new NoBuildingCodeError(ErrorType.Severity.CRITICAL, date);
            Cell<String> errorCell = new Cell<>(row, column, format.toString());
            Error<T> timeError = new SheetError<T>(errorCell, type);
            manager.addError(timeError, item);
        }
        return stamp;
    }

    /**
     * Parses and validates the timestamp
     * @param row - row of the cell we are validating
     * @param column - column of the cell that we are validating
     * @param format - The date format to parse the string
     * @param date - The string representation of the date
     * @param item - Item to add to the error.
     * @param direction - The direction that the propagating error should be applied (row or column)
     * @return If parse was successful returns timestamp otherwise returns null.
     */
    public Timestamp validateTimestamp(int row, int column, DateFormat format, String date, T item, SheetErrorData.Direction direction) {
        Timestamp stamp = null;
        try {
            Date time = format.parse(date);
            stamp = new Timestamp(time.getTime());
        } catch (ParseException ex) {
            ErrorType type = new NoBuildingCodeError(ErrorType.Severity.CRITICAL, date);
            Cell<String> errorCell = new Cell<>(row, column, format.toString());
            Error<T> timeError = new SheetError<T>(errorCell, type, true, direction);
            manager.addError(timeError, item);
        }
        return stamp;
    }
}
