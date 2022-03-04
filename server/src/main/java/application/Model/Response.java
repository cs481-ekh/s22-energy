package application.Model;

import application.Database.EnergyDB.Models.Usage;

import java.util.ArrayList;
import java.util.List;

public class Response {
    // MODIFY Usage to UsageSummary class when PR Merges
    private Usage usage;
    private List<Error> errors;
    private List<Usage> success;

    public Response(){
        usage = new Usage();
        errors = new ArrayList<Error>();
        success = new ArrayList<Usage>();
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
    public void setSuccessList(List<Usage> successList){
        success = successList;
    }
    public void addSuccess(Usage usage){
        success.add(usage);
    }
    public boolean hasError(){
        return errors.size() > 0;
    }
}
