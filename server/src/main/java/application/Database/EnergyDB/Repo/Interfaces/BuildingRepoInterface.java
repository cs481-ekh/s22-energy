package application.Database.EnergyDB.Repo.Interfaces;

import application.Database.EnergyDB.Models.Building;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

/**
 * Used for spring boot to use a Building as a JpaRepository.
 */
public interface BuildingRepoInterface {
    /**
     * Get all the buildings from the database
     * @return the entire buildings table :)
     */
    @Query("SELECT b FROM Building b")
    Optional<List<Building>> getAllBuildings();

    /**
     * Finds the building associated with the building code.
     * @param buildingCode - Building code.
     * @return the building associated with code.
     */
    @Query("SELECT b FROM Building b WHERE b.buildingCode = ?1")
    Optional<Building> getBuildingByCode(String buildingCode);

    /**
     * Finds the building associated with an address.
     * @param address - Address to find building for.
     * @return - building at address.
     */
    @Query("SELECT b FROM Building b WHERE b.address = ?1")
    Optional<Building> getBuildingByAddress(String address);

}
