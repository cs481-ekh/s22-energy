package application;


import application.CSV.CsvParser;
import application.CSV.NaturalGasParser;
import application.CSV.SmallElectricParser;
import application.CSV.SolarParser;
import application.Database.EnergyDB.Models.Usage;
import application.Database.EnergyDB.Repo.JPARepository.BuildingRepo;
import application.Database.EnergyDB.Repo.JPARepository.PremiseRepo;
import application.Database.EnergyDB.Repo.JPARepository.UsageRepo;
import application.controller.filecontroller.FileStorageProperties;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.Instant;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.transaction.annotation.EnableTransactionManagement;


/**
 * application.Server class.
 */
@EnableTransactionManagement
@SpringBootApplication
@EnableConfigurationProperties({FileStorageProperties.class})
public class Server implements ApplicationRunner {

    @Autowired
    static final transient Logger logger = LoggerFactory.getLogger(Server.class);

    @Autowired
    UsageRepo repo;
    @Autowired
    PremiseRepo premiseRepo;
    @Autowired
    BuildingRepo buildRepo;

    /**
     * Main method.
     */
    public static void main(String[] args) {
        SpringApplication.run(Server.class, args);
    }
    @Override
    public void run(ApplicationArguments arg0) throws Exception {
        Usage bob = new Usage();
        bob.buildingCode = "306";
        bob.cost = new BigDecimal(1000);
        bob.timestamp = Timestamp.from(Instant.now());
        bob.utilityID = 1;
        bob.utilityUsage = new BigDecimal(5);
        repo.upsertUsage(bob);
    }
}
