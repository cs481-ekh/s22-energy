package application.Database.EnergyDB.Repo.JPARepository;

import application.Database.EnergyDB.Repo.Interfaces.BuildingRepoInterface;
import org.springframework.data.jpa.repository.JpaRepository;

import application.Database.EnergyDB.Models.Building;

/**
 * Repository to communicate with buildings table in DB.
 */
public interface BuildingRepo extends JpaRepository<Building, String> , BuildingRepoInterface {
}
