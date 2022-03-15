package ErrorManagement.CSV;

import ErrorManagement.ErrorData;

/**
 * Defines the internal error data for a sheet error.
 */
public class SheetErrorData implements ErrorData {
    private boolean propagate;
    private Cell<String> errorCell;
    private Direction direction;

    // Direction of propagating error
    public enum Direction{
        ROW,
        COLUMN
    }

    public SheetErrorData(){
        errorCell = null;
        this.direction = null;
        this.propagate = false;
    }

    public SheetErrorData(Cell<String> cell, boolean propagate, Direction direction){
        errorCell = cell;
        this.direction = direction;
        this.propagate = propagate;
    }

    public SheetErrorData(Cell<String> cell){
        errorCell = cell;
        this.direction = null;
        this.propagate = false;
    }

    /**
     * Returns itself
     * @return sheet error data
     */
    public SheetErrorData getData() {
        return this;
    }

    /**
     * Determines whether the sheet error propagates or not.
     * @return boolean, true if propagate, false other wise
     */
    public boolean doesPropagate(){
        return propagate;
    }

    /**
     * Direction of the propagating error.
     * @return direction of the error
     */
    public Direction direction(){
        return direction;
    }

    /**
     * Gets the cell that the error belonged to.
     * @return
     */
    public Cell<String> getCell(){
        return errorCell;
    }

    @Override
    public String toString(){
        String returnString = "";
        if(errorCell != null){
            returnString = errorCell.toString();
        }
        return returnString;
    }

}
