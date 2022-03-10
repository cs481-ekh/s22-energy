package application.Database.EnergyDB.Repo.JPARepository;

import application.Database.EnergyDB.Models.Utility;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Repository to communicate with utility table in DB.
 */
public interface UtilityRepo extends JpaRepository<Utility, Integer> {

}
