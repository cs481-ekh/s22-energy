package application.controller;

import application.Database.EnergyDB.Models.User;
import application.Database.EnergyDB.Repo.JPARepository.UserRepo;
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
import java.util.Arrays;
import java.util.Optional;


@CrossOrigin("*")
@RestController
public class UserController {

    @Autowired
    UserRepo userRepo;

    public boolean addUser(@RequestParam String email, @RequestParam String Password) {
        
    }

    /**
     * Gets all the buildings from the buildings database
     * @return list of usage that matched criteria.
     */
    @GetMapping(value = "/login")
    public Boolean getUser(@RequestParam String email, @RequestParam String password) throws NoSuchAlgorithmException {
        Boolean response = null;

        Optional<User> user = Optional.of(new User());
        // Runs query on db
        String hashedPassword = hashPassword(password, email);
        user = userRepo.getUser(email, hashedPassword);

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

    /**
     * Hash the password before interacting with the database
     * @param password
     * @param email
     * @return
     * @throws NoSuchAlgorithmException
     */
    private String hashPassword(String password, String email) throws NoSuchAlgorithmException {
        // randomly generated salt
        String salt = "PT0zs3AhIpB8CqCJCxcG";

        // hash the password with the appended salt
        PasswordEncoder pe = new BCryptPasswordEncoder();
        return pe.encode(password + salt);
    }
}
