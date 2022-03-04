package application.Model;

import application.Database.EnergyDB.Models.Usage;

public class Error {

    private String errorMessage;
    private Usage errorUsage;

    public Error(){
        errorUsage = new Usage();
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
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
