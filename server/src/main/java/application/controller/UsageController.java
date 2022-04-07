package application.controller;

import application.Database.EnergyDB.Models.Building;
import application.Database.EnergyDB.Models.Usage;
import application.Database.EnergyDB.Models.Utility;
import application.Database.EnergyDB.Repo.JPARepository.UsageRepo;
import application.Database.EnergyDB.Repo.JPARepository.UtilityRepo;
import application.Model.Response;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.*;
import java.util.*;


@CrossOrigin("*")
@RestController
public class UsageController {
    @Autowired
    UsageRepo usageRepo;
    @Autowired
    UtilityRepo utilityRepo;

    /**
     * Gets the usages given the
     * @param startDate - The date in which you want to start looking for usages
     * @param endDate - The last date you want to start looking for usages
     * @param utilityIDs - The utility id to filter usages by
     * @return list of usage that matched criteria.
     */
    @GetMapping(value = "/usage")
    public Map<Integer, List<Usage>> retrieveUsage(@RequestParam ("start")
                                      @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Optional<Date> startDate,
                                  @RequestParam ("end")
                                  @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Optional<Date> endDate,
                                  @RequestParam ("utilID" )Optional<List<Integer>> utilityIDs) {

        Timestamp start = null;
        Timestamp end = null;

        Map<Integer, List<Usage>> usageBuckets = new HashMap<>();

        // Gets the current date -1 month for a default value
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.MONTH, -1);
        Date defaultStart = calendar.getTime();

        // Uses the default end as the current date.
        Date defaultEnd = Date.from(Instant.now());

        // Calculates the actual timestamp given default or user input
        Timestamp actualStart = Timestamp.from(startDate.orElse(defaultStart).toInstant());
        Timestamp actualEnd = Timestamp.from(endDate.orElse(defaultEnd).toInstant());

        Optional<List<Usage>> usageList;
        List<Integer> utilityIDList;

        // Runs query on db
        if (utilityIDs.isEmpty()) {
            // Finds all utilities
            List<Utility> utilities = utilityRepo.findAll();

            // Gets a list of all utility ids
            utilityIDList = utilities.stream().map(utility -> utility.utilityID).toList();
        } else {
            utilityIDList = utilityIDs.get();
        }

        for(int utilID: utilityIDList){
            // Gets usages for each id.
            usageList = usageRepo.getUsageDateRange(actualStart, actualEnd, utilID);
            // Gets the result.
            if (usageList.isPresent()) {
                List<Usage> usageResult = usageList.get();
                usageBuckets.put(utilID, usageResult);
            }
        }
        return usageBuckets;
    }
}
