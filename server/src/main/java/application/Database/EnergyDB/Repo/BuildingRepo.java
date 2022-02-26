package application.Database.EnergyDB.Repo;

import application.Database.EnergyDB.Models.Building;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BuildingRepo extends JpaRepository<Building, Integer> {
}
