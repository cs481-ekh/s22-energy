package application.Model;

import application.Database.EnergyDB.Models.Usage;

import java.util.ArrayList;
import java.util.List;

/**
 * Model for returning a response to the front end.
 */
public class Response {
    private UsageSummary summary;
    private List<ErrorGroup> errors;
    private List<Usage> success;

    public Response(){
        summary = new UsageSummary();
        success = new ArrayList<Usage>();
        errors = new ArrayList<ErrorGroup>();
    }

    /**
     * Generates summary based off successfully implemented usages.
     */
    public void calculateSummary(){
        summary.generateSummary(success);
    }


    /**
     * Overwrites the success list with new reference
     * @param successList - list to set internal list to.
     */
    public void setSuccessList(List<Usage> successList){
        success = successList;
    }

    /**
     * Adds a success to the list.
     * @param usage
     */
    public void addSuccess(Usage usage){
        success.add(usage);
    }

    /**
     * Determines if there are errors in the response.
     * @return
     */
    public boolean hasError(){
        return errors.size() > 0;
    }
}
