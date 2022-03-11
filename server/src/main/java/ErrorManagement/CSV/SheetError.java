package ErrorManagement.CSV;
import ErrorManagement.Error;
import ErrorManagement.ErrorManager;

public class SheetError<T> extends Error<T>{

    private boolean propagate;

    private Cell<T> errorCell;
    private Direction direction;

    @Override
    public void modifyMangementState(ErrorManager<T> manager) {
    }

    public enum Direction{
        ROW,
        COLUMN
    }
    public SheetError(){
        propagate = false;
        direction = null;
    }

    public void setCell(Cell<T> cell){
        errorCell = cell;
    }
    public Cell<T> getCell(){
        return errorCell;
    }

    public Direction getDirection(){
        return direction;
    }
    public void setDirection(Direction direction){
        this.setDirection(direction);
    }
    public void setPropagate(boolean propagate){
        this.propagate = propagate;
    }
    public boolean getPropagate(){
        return propagate;
    }

}
