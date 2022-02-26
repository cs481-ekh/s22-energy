package application.Database.EnergyDB.Repo;

import application.Database.EnergyDB.Models.Usage;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UsageRepo extends JpaRepository<Usage, Integer> {
}
