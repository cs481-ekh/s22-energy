package ErrorManagement.CSV;

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
        return " Cell at row " + rowIndex + " and column: " + columnIndex + " with value " + value.toString();
    }

    @Override
    public void modifyManagementData() {

    }
}
