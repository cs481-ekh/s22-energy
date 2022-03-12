package application;

<<<<<<< HEAD
import application.CSV.CsvParser;
import application.CSV.NaturalGasParser;
import application.CSV.SmallElectricParser;
=======
import application.CSV.SolarParser;
>>>>>>> solarParser
import application.Database.EnergyDB.Repo.JPARepository.BuildingRepo;
import application.Database.EnergyDB.Repo.JPARepository.PremiseRepo;
import application.Database.EnergyDB.Repo.JPARepository.UsageRepo;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
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
<<<<<<< HEAD
        var p = new NaturalGasParser("/Users/tpoulsen/Code/Energy/docs/naturalGas.csv", 1, premiseRepo);
=======
        var p = new SolarParser("/Users/tpoulsen/Code/Energy/docs/solar.csv", 7);
>>>>>>> solarParser
        p.readData();
    }
}
