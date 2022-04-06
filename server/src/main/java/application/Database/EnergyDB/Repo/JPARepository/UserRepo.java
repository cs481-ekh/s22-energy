package application.Database.EnergyDB.Repo.JPARepository;

import application.Database.EnergyDB.Models.User;
import application.Database.EnergyDB.Repo.Interfaces.UserRepoInterface;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Repository to communicate with user table in DB.
 */
public interface UserRepo extends JpaRepository<User, String>, UserRepoInterface {
}
