package application.controller;

import application.Database.EnergyDB.Models.User;
import application.Database.EnergyDB.Repo.JPARepository.UserRepo;
import application.Datasource;
import application.Model.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;

import java.security.NoSuchAlgorithmException;
import java.util.Optional;


@CrossOrigin("*")
@RestController
public class UserController {

    @Autowired
    UserRepo userRepo;

    /**
     * check whether a user/password pair exist in the database
     * @param email
     * @param password
     * @return true if the pair exists, false if not
     */
    @GetMapping(value = "/login")
    public boolean getUser(@RequestParam String email, @RequestParam String password) throws NoSuchAlgorithmException {
        // try to get the user from the database, if they exist
        Optional<User> user = userRepo.getUser(email, hashPassword(password));

        // return the result
        return user.isPresent();
    }

    @GetMapping(value = "/signup")
    public boolean addAdmin(@RequestParam String email, @RequestParam String password) throws NoSuchAlgorithmException {
        // add the new admin user to the database
        System.out.println("Adding new admin user: " + email);
        userRepo.save(new User(email, hashPassword(password), true));

        // confirm the user was added, and return the response
        boolean result = getUser(email, hashPassword(password));
        if (result)
            System.out.println("Successfully added new admin user: " + email);
        else
            System.out.println("Failed to add new admin user: " + email);
        return result;
    }


    // hash the password
    private String hashPassword(String password) throws NoSuchAlgorithmException {
        // randomly generated salt
        String salt = "PT0zs3AhIpB8CqCJCxcG";

        // hash the password with the appended salt
        PasswordEncoder pe = new BCryptPasswordEncoder();
        return pe.encode(password + salt);
    }
}
