package application.Database.EnergyDB.Repo.Interfaces;

import application.Database.EnergyDB.Models.User;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;

public interface UserRepoInterface {

    @Query("Select u from User u WHERE u.email = :email and u.password = :password")
    Optional<User> getUser(String email, String password);
}
