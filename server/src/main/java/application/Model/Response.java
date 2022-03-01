package application.Model;

import application.Database.EnergyDB.Models.Usage;

import java.util.ArrayList;

public class Response {

    private Usage usage;
    private ArrayList<Error> errors;

    public Response(){
        usage = new Usage();
        errors = new ArrayList<Error>();
    }

    public void setError(Error error){
        errors.add(error);
    }
    public void setUsage(Usage summary){
        usage = summary;
    }
    public int getErrorCount(){
        return errors.size();
    }
}
