package application.Database.EnergyDB.Repo;

import application.Database.EnergyDB.Models.Utility;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UtilityRepo extends JpaRepository<Utility, Integer> {
}
