package application;

import application.Database.EnergyDB.Models.Building;
import application.Database.EnergyDB.Models.Usage;
import application.Database.EnergyDB.Repo.JPARepository.PremiseRepo;
import application.Database.EnergyDB.Repo.JPARepository.UsageRepo;
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
import org.springframework.transaction.annotation.EnableTransactionManagement;


/**
 * application.Server class.
 */
@EnableTransactionManagement
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class, HibernateJpaAutoConfiguration.class})
public class Server implements ApplicationRunner {

    @Autowired
    static final transient Logger logger = LoggerFactory.getLogger(Server.class);

    @Autowired
    UsageRepo repo;
    @Autowired
    PremiseRepo premRepo;

    /**
     * Main method.
     */
    public static void main(String[] args) {
        SpringApplication.run(Server.class, args);
    }
    @Override
    public void run(ApplicationArguments arg0) throws Exception {
        System.out.println("Hello World from Application Runner");
        List<Usage> usageList = new ArrayList<Usage>();
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/mm/yyyy");
        Date date = dateFormat.parse("23/09/2007");
        Usage usage = new Usage();
        usage.utilityUsage = new BigDecimal(25);
        usage.cost = new BigDecimal(25);
        usage.timestamp = new Timestamp(date.getTime());

        Usage usage2 = new Usage();
        date = dateFormat.parse("23/09/2008");
        usage2.utilityUsage = new BigDecimal(25);
        usage2.cost = new BigDecimal(25);
        usage2.timestamp = new Timestamp(date.getTime());

        usageList.add(usage);
        usageList.add(usage2);

        UsageSummary summary = new UsageSummary();
        summary.generateSummary(usageList);
    }
}
