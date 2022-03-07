package application.Model;

import application.Database.EnergyDB.Models.Usage;


public class Error {

    private String errorMessage;
    private Errors errorType;
    private Usage errorUsage;
    private boolean errorSet;

    // List of possible error types
    public enum Errors
    {
        MISSINGPREMISE,
        DATAFORMAT,
        NULLEXCEPTION,
        NOBUILDING,
        FAILEDREGEX,
        DATEFORMAT,
    }

    public Error(){
        errorUsage = new Usage();
        errorSet = false;
    }

    public Error(String errorMessage, Errors errorType){
        this.errorMessage = errorMessage;
        this.errorType = errorType;
        errorUsage = new Usage();
        errorSet = true;
    }

    public void setErrorMessage(String errorMessage, Errors errorType) {
        this.errorMessage = errorMessage;
        this.errorType = errorType;
        this.errorSet = true;
    }
    public boolean hasError(){
        return errorSet;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorUsage(Usage errorUsage) {
        this.errorUsage = errorUsage;
        this.errorSet = true;
    }

    public Usage getErrorUsage() {
        return errorUsage;
    }
}

