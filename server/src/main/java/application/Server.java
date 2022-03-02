package application;

import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.orm.jpa.HibernateJpaAutoConfiguration;

import application.Database.EnergyDB.Models.Building;
import application.Database.EnergyDB.Repo.BuildingRepo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;


/**
 * application.Server class.
 */
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class, HibernateJpaAutoConfiguration.class})
public class Server {

    @Autowired
    static final transient Logger logger = LoggerFactory.getLogger(Server.class);
    static BuildingRepo Repo;

    /**
     * Main method.
     */
    public static void main(String[] args) {
        List<Building> list = new ArrayList<Building>(); 
        SpringApplication.run(Server.class, args);
        list = Repo.getBuildingCodeForPremiseID();
        logger.error(list.get(0).buildingCode);
    }
}
