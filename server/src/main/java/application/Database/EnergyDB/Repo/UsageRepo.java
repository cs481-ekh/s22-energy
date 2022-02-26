package application.Database.EnergyDB.Repo;

import application.Database.EnergyDB.Models.Usage;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Used for spring boot to use a Usage as a JpaRepository.
 */
public interface UsageRepo extends JpaRepository<Usage, Integer> {

}
