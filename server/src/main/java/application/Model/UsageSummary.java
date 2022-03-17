package application.Model;

import application.Database.EnergyDB.Models.Usage;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.Date;
import java.util.List;

public class UsageSummary {
    public Timestamp start;
    public Timestamp end;

    public BigDecimal utilityUsage;
    public BigDecimal cost;

    public UsageSummary(){
        utilityUsage = new BigDecimal(0);
        cost = new BigDecimal(0);
    }

    /**
     * Calculates the usage summary based off the specified list of usages.
     * @param usageList - A list of usages
     */
    public void generateSummary(List<Usage> usageList){
        // Sets start and end to the min and max possible values
        // This is so compareTo will always modify in first iteration
        Timestamp start = new Timestamp(Long.MAX_VALUE);
        Timestamp end = new Timestamp(Long.MIN_VALUE);
        for(Usage usage : usageList){
            if(usage.timestamp != null){
                // Compare to see if the usage timestamp is less than current start
                start = start.compareTo(usage.timestamp) > 0 ? usage.timestamp : start;

                // Compare to see if usage timestamp is greater than current end.
                end = end.compareTo(usage.timestamp) < 0 ? usage.timestamp : end;
            }
            // Set values as loop iterates
            this.cost = cost.add(usage.cost);
            this.utilityUsage= utilityUsage.add(usage.utilityUsage);
            this.start = start;
            this.end = end;
        }
    }
    public Timestamp getStart() {
        return start;
    }

    public Timestamp getEnd() {
        return end;
    }

    public BigDecimal getUtilityUsage() {
        return utilityUsage;
    }

    public BigDecimal getCost() {
        return cost;
    }
}
