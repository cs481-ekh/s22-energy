package application.controller;

import application.Database.EnergyDB.Models.Building;
import application.Database.EnergyDB.Models.Usage;
import application.Database.EnergyDB.Repo.JPARepository.UsageRepo;
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

    /**
     * Gets the usages given the
     * @param startDate - The date in which you want to start looking for usages
     * @param endDate - The last date you want to start looking for usages
     * @param utilityID - The utility id to filter usages by
     * @return list of usage that matched criteria.
     */
    @GetMapping(value = "/usage", consumes = MediaType.APPLICATION_JSON_VALUE)
    public List<Usage> uploadFile(@RequestParam ("start")
                                      @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Optional<Date> startDate,
                                  @RequestParam ("end")
                                  @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Optional<Date> endDate,
                                  @RequestParam ("utilID" )Optional<Integer> utilityID) {

        List<Usage> usageResult = new ArrayList<>();

        Timestamp start = null;
        Timestamp end = null;

        // Gets the current date -1 month for a default value
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.MONTH, -1);
        Date defaultStart = calendar.getTime();

        // Uses the default end as the current date.
        Date defaultEnd = Date.from(Instant.now());

        // Calculates the actual timestamp given default or user input
        Timestamp actualStart = Timestamp.from(startDate.orElse(defaultStart).toInstant());
        Timestamp actualEnd = Timestamp.from(endDate.orElse(defaultEnd).toInstant());

        Optional<List<Usage>> usage;

        // Runs query on db
        if (utilityID.isEmpty()) {
            usage = usageRepo.getUsageDateRange(actualStart, actualEnd);
        } else {
            Integer utilID = utilityID.get();
            usage = usageRepo.getUsageDateRange(actualStart, actualEnd, utilID);
        }

        // Gets the result.
        if (usage.isPresent()) {
            usageResult = usage.get();
        }
        return usageResult;
    }
}
