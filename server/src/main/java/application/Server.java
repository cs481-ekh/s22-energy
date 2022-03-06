package application;

import application.CSV.CsvParser;
import application.CSV.ElectricDemandParser;
import application.Database.EnergyDB.Models.Building;
import application.Database.EnergyDB.Models.Usage;
import application.Database.EnergyDB.Repo.JPARepository.BuildingRepo;
import application.Database.EnergyDB.Repo.JPARepository.PremiseRepo;
import application.Database.EnergyDB.Repo.JPARepository.UsageRepo;
import application.Model.Response;
import application.Model.UsageSummary;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.orm.jpa.HibernateJpaAutoConfiguration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.transaction.annotation.EnableTransactionManagement;


/**
 * application.Server class.
 */
@EnableTransactionManagement
@SpringBootApplication
public class Server implements ApplicationRunner {

    @Autowired
    static final transient Logger logger = LoggerFactory.getLogger(Server.class);

    @Autowired
    UsageRepo repo;
    @Autowired
    PremiseRepo premRepo;

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
        CsvParser parser = new ElectricDemandParser("/home/aidanleuck/Downloads/Data.csv", 2, buildRepo);
        Response response = parser.readData();
    }
}
