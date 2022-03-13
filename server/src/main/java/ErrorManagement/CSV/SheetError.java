package ErrorManagement.CSV;
import ErrorManagement.Error;
import ErrorManagement.ErrorTypes.ErrorType;

/**
 * Defines errors and their properties for a sheet.
 * @param <T> - Type of item to hold in the error.
 */
public class SheetError<T> extends Error<T>{

    /**
     * Sets the internal error data of a sheet error
     * @param errorCell - Cell in which error occured
     * @param type - Type of error that occurred
     * @param propagate - Whether the error is propagating or not
     * @param direction - Direction the error propagates
     */
    public SheetError(Cell<String> errorCell, ErrorType type, boolean propagate, SheetErrorData.Direction direction){
        super(type);
        errorData = new SheetErrorData(errorCell, propagate, direction);
    }

    /**
     * Sets the internal error data of a sheet error
     * @param errorCell - Cell in which error occurred
     * @param type - Type of error that occurred
     */
    public SheetError(Cell<String> errorCell, ErrorType type){
        super(type);
        errorData = new SheetErrorData(errorCell);
    }

}
