package application.Database.EnergyDB.Repo.JPARepository;

import application.Database.EnergyDB.Models.Usage;
import application.Database.EnergyDB.Repo.Interfaces.UsageInterface;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Repository to communicate with utility table in DB.
 */
public interface UsageRepo extends JpaRepository<Usage, Integer>, UsageInterface {
}
