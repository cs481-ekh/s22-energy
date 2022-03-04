package application.Model;

import application.Database.EnergyDB.Models.Usage;


public class Error {

    private String errorMessage;
    private Errors errorType;
    private Usage errorUsage;

    // List of possible error types
    public enum Errors
    {
        MISSINGPREMISE,
        DATAFORMAT,
        NULLEXCEPTION
    }

    public Error(){
        errorUsage = new Usage();
    }

    public Error(String errorMessage, Errors errorType){
        this.errorMessage = errorMessage;
        this.errorType = errorType;
        errorUsage = new Usage();
    }

    public void setErrorMessage(String errorMessage, Errors errorType) {
        this.errorMessage = errorMessage;
        this.errorType = errorType;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorUsage(Usage errorUsage) {
        this.errorUsage = errorUsage;
    }

    public Usage getErrorUsage() {
        return errorUsage;
    }
}

