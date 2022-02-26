package application.Database.EnergyDB.Repo;

import application.Database.EnergyDB.Models.Premise;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PremiseRepo extends JpaRepository<Premise, Integer> {
}
