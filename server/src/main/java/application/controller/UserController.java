package application.controller;

import application.Database.EnergyDB.Models.User;
import application.Database.EnergyDB.Repo.JPARepository.UserRepo;
import application.Datasource;
import application.Model.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;


@CrossOrigin("*")
@RestController
public class UserController {

    @Autowired
    UserRepo userRepo;

    /**
     * Gets all the buildings from the buildings database
     * @return list of usage that matched criteria.
     */
    @GetMapping(value = "/login")
    public Boolean getUser(@RequestParam String email, @RequestParam String password){
        Boolean response = null;

        Optional<User> user = Optional.of(new User());
        // Runs query on db
        user = userRepo.getUser(email, password);

        User loginResult = new User();

        // Gets the result
        if (user.isPresent()) {
            loginResult = user.get();
            response = true;
        } else {
            response = false;
        }

        return response;
    }
}
