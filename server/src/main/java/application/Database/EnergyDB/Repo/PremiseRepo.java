package application.Database.EnergyDB.Repo;

import application.Database.EnergyDB.Models.Premise;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Used for spring boot to use a Premise as a JpaRepository.
 */
public interface PremiseRepo extends JpaRepository<Premise, Integer> {

}
