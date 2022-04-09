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


    // hash the password
    private String hashPassword(String password, String email) throws NoSuchAlgorithmException {
        // hash the email to generate a unique salt for every user
        MessageDigest md = MessageDigest.getInstance("MD5");
        byte[] salt = md.digest(email.getBytes(StandardCharsets.UTF_8));

        // hash the password with the appended salt
        PasswordEncoder pe = new BCryptPasswordEncoder();
        return pe.encode(password + salt.toString());
    }
}
