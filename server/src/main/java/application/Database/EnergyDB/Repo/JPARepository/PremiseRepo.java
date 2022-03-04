package application.Database.EnergyDB.Repo.JPARepository;

import application.Database.EnergyDB.Models.Premise;
import application.Database.EnergyDB.Repo.Interfaces.PremiseRepoInterface;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Repository to communicate with premise table in DB.
 */
public interface PremiseRepo extends JpaRepository<Premise, Long>, PremiseRepoInterface {
}
