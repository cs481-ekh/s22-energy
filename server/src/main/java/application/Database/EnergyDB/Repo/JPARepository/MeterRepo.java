package application.Database.EnergyDB.Repo.JPARepository;

import application.Database.EnergyDB.Models.Meter;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Repository to communicate with Meter table in DB.
 */
public interface MeterRepo extends JpaRepository<Meter, Integer> {
}
