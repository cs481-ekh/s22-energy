package ErrorManagement.CSV;

import java.util.Objects;

public class Cell<T>{
    private int rowIndex;
    private int columnIndex;
    private T value;

    public Cell(int rowIndex, int columnIndex, T value){
        this.columnIndex = columnIndex;
        this.rowIndex = rowIndex;
        this.value = value;
    }

    @Override
    public String toString() {
        return "at row " + rowIndex + " and column: " + columnIndex + " with value " + value.toString();
    }

    /**
     * Returns the row index of cell.
     * @return
     */
    public int getRow(){
        return rowIndex;
    }

    /**
     * Returns the column index of cell.
     * @return
     */
    public int getColumn(){
        return columnIndex;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Cell<?> cell = (Cell<?>) o;
        return rowIndex == cell.rowIndex &&
                columnIndex == cell.columnIndex;
    }

    @Override
    public int hashCode() {
        return Objects.hash(rowIndex, columnIndex);
    }
}
