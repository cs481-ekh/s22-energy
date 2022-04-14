package application.controller;

import application.Database.EnergyDB.Models.User;
import application.Database.EnergyDB.Models.Utility;
import application.Database.EnergyDB.Repo.JPARepository.UserRepo;
import application.Database.EnergyDB.Repo.JPARepository.UtilityRepo;
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
import java.util.List;
import java.util.Optional;


@CrossOrigin("*")
@RestController
public class UtilityController {

    @Autowired
    UtilityRepo repo;

    /**
     * Gets all the utilities in the db.
     * @return list of all utilities in db.
     */
    @GetMapping(value = "/utilities")
    public List<Utility> getUtilities(){
        return repo.findAll();
    }
}
