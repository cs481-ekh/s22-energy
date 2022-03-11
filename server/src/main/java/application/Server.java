package application;

import application.CSV.CsvParser;
import application.CSV.SmallElectricParser;
import application.Database.EnergyDB.Repo.JPARepository.BuildingRepo;
import application.Database.EnergyDB.Repo.JPARepository.PremiseRepo;
import application.Database.EnergyDB.Repo.JPARepository.UsageRepo;
import application.Model.Response;
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
//        CsvParser parser = new SmallElectricParser("docs/small_elec.csv",2, premiseRepo);
//        Response response = parser.readData();
    }
}
