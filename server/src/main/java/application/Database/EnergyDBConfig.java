package application.Database;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.transaction.PlatformTransactionManager;

import javax.sql.DataSource;
import java.util.HashMap;

@Configuration
@PropertySource({ "classpath:application.properties" })
@EnableJpaRepositories(
		basePackages = "application.Database.EnergyDB",
		entityManagerFactoryRef = "energyEntityManager",
		transactionManagerRef = "energyTransactionManager"
)
/**
 * Configures connection to main energy db.
 */
public class EnergyDBConfig {
	@Autowired
	private transient Environment env;
	private final transient Logger logger = LoggerFactory.getLogger(getClass());

	@Bean
	@Primary
	/**
	 * Manages which entities this configuration applies to.
	 * @returns entity factory for all models under package models.
	 */
	public LocalContainerEntityManagerFactoryBean energyEntityManager() {
		LocalContainerEntityManagerFactoryBean em
				= new LocalContainerEntityManagerFactoryBean();
		em.setDataSource(energyDataSource());
		em.setPackagesToScan(
				new String[] { "application.Database.EnergyDB.Models" });

		// Configures how the Jpa adapter should interact with the database
		HibernateJpaVendorAdapter vendorAdapter
				= new HibernateJpaVendorAdapter();
		em.setJpaVendorAdapter(vendorAdapter);
		HashMap<String, Object> properties = new HashMap<>();
		properties.put("hibernate.hbm2ddl.auto",
				env.getProperty("hibernate.hbm2ddl.auto"));
		properties.put("hibernate.dialect",
				env.getProperty("hibernate.dialect"));
		em.setJpaPropertyMap(properties);
		return em;
	}

	@Primary
	@Bean
	/**
	 * Handles connection to the database.
	 * @returns a database connection.
	 */
	public DataSource energyDataSource() {
		DriverManagerDataSource dataSource = new DriverManagerDataSource();

		// Sets login and host information for the connection
		dataSource.setDriverClassName(
				env.getProperty("spring.energydb.driver"));
		dataSource.setUrl(env.getProperty("spring.energydb.url"));
		dataSource.setUsername(env.getProperty("spring.energydb.username"));
		dataSource.setPassword(env.getProperty("spring.energydb.password"));
		logger.debug("Succesfully connected to db!");
		return dataSource;
	}

	@Primary
	@Bean
	/**
	 * Sets up a manager for a transaction between db and entity.
	 * @returns a transaction manager for spring boot to use internally.
	 */
	public PlatformTransactionManager energyTransactionManager() {

		JpaTransactionManager transactionManager = new JpaTransactionManager();
		transactionManager.setEntityManagerFactory(
				energyEntityManager().getObject());
		return transactionManager;
	}
}
