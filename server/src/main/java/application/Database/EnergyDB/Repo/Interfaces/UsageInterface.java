package application.Database.EnergyDB.Repo.Interfaces;

import application.Database.EnergyDB.Models.Building;
import application.Database.EnergyDB.Models.Usage;
import application.Model.UsageSummary;

import org.hibernate.query.NativeQuery;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import javax.transaction.Transactional;
import java.sql.Timestamp;
import java.util.List;
import java.util.Optional;

public interface UsageInterface {
    /**
     * Gets usage items from start timestamp to the current date
     * @param start - Start timestamp
     * @return - A list of usages in the date range
     */
    @Query("Select u from Usage u WHERE u.timestamp >= ?1 and u.timestamp <= CURRENT_TIMESTAMP")
    Optional<List<Usage>> getUsageDateRange(Timestamp start);

    /**
     * Gets usage items from start timestamp to the end date
     * @param start - Start timestamp
     * @param end - End timestamp
     * @return - A list of usages in the date range
     */
    @Query("Select u from Usage u WHERE u.timestamp >= ?1 and u.timestamp <= ?2")
    Optional<List<Usage>> getUsageDateRange(Timestamp start, Timestamp end);

    /**
     * Gets usage items from start timestamp to the current date
     * @param start - Start timestamp
     * @param utilityID - Utility id to filter by
     * @return - A list of usages in the date range filtered by utility type
     */
    @Query("Select u from Usage u WHERE u.timestamp >= ?1 and u.timestamp <= CURRENT_TIMESTAMP and u.utilityID = ?2")
    Optional<List<Usage>> getUsageDateRange(Timestamp start, int utilityID);

    /**
     * Gets usage items from start timestamp to the end date
     * @param start - Start timestamp
     * @param end - End timestamp
     * @param utilityID - Utility id to filter by
     * @return - A list of usages in the date range
     */
    @Query("Select u from Usage u WHERE u.timestamp >= ?1 and u.timestamp <= ?2 and u.utilityID = ?3")
    Optional<List<Usage>> getUsageDateRange(Timestamp start, Timestamp end, int utilityID);

    /**
     * 
     */
    @Modifying
    @Transactional
    @Query(value = "Insert Into usage(building_code, utility_id, time_stamp, usage, cost, premise_id) "
        + "Values(:#{#u.buildingCode}, :#{#u.utilityID}, :#{#u.timestamp}, :#{#u.utilityUsage}, :#{#u.cost}, :#{#u" +
            ".premiseID}) "
        + "On Conflict On Constraint duplicate_usage Do Update Set usage = EXCLUDED.usage, cost = EXCLUDED.cost",
        nativeQuery = true)
    void upsertUsage(@Param("u") Usage usage);
}
