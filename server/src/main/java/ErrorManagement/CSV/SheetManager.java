package ErrorManagement.CSV;

import ErrorManagement.Error;
import ErrorManagement.ErrorManager;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class SheetManager<T> implements ErrorManager<T> {
    private Map<Integer, List<Error<T>>> rowErrors;
    private Map<Integer, List<Error<T>>> columnErrors;
    private List<Error<T>> errorList;
    public Error test;

    public SheetManager() {
        super();
        errorList = new ArrayList<>();
    }

    @Override
    public List<Error<T>> getErrors() {
        return errorList;
    }

    @Override
    public void addError(Error<T> error) {

    }

    @Override
    public void printErrors() {

    }

    @Override
    public void runManagement() {

    }

}
