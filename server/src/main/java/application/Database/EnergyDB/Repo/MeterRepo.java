package application.Database.EnergyDB.Repo;

import application.Database.EnergyDB.Models.Meter;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MeterRepo extends JpaRepository<Meter, Integer>{

}


