package ErrorManagement;

import ErrorManagement.ErrorTypes.ErrorType;

import java.util.List;

public abstract class Error<T> {
    private ErrorType errorType;
    private List<T> items;

    public void addItem(T item){
        items.add(item);
    }
    public List<T> getItems() {
        return items;
    }

    public abstract void modifyMangementState(ErrorManager<T> manager);

    public String getErrorMessage(){
        return errorType.generateErrorMessage();
    }
    public  ErrorType.Severity getSeverity(){
        return errorType.getSeverity();
    }
}