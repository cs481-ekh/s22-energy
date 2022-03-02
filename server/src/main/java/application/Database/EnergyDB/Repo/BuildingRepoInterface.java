package application.Database.EnergyDB.Repo;

import application.Database.EnergyDB.Models.Building;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

/**
 * Used for spring boot to use a Building as a JpaRepository.
 */
public interface BuildingRepoInterface {
    // SELECT u FROM User u WHERE u.status = 1
    @Query("SELECT b FROM Building b WHERE b.buildingCode = '004'")
    public List<Building> getBuildingCodeForPremiseID(); 
}
