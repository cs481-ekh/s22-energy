package application.Database.EnergyDB.Repo;

import application.Database.EnergyDB.Models.Meter;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Used for spring boot to use a Meter as a JpaRepository.
 */
public interface MeterRepo extends JpaRepository<Meter, Integer>{

}


