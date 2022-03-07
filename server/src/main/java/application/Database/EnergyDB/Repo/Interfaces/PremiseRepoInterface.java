package application.Database.EnergyDB.Repo.Interfaces;

import application.Database.EnergyDB.Models.Building;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;

public interface PremiseRepoInterface {
    /**
     * Determines the building that belongs to the specified premiseID
     * @param premiseID - Premise ID to find building code for
     * @return - Building that matches premise id (if it exists)
     */
    @Query("SELECT b FROM Building b WHERE b.buildingCode IN " +
            "(SELECT p.buildingCode from Premise p WHERE p.premiseID = :premiseID)")
    Optional<Building> getPremiseBuilding(long premiseID);
}
