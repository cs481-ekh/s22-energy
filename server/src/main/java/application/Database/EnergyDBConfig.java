package application.Database;

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
public class EnergyDBConfig {
	@Autowired
	private Environment env;

	@Bean
	@Primary
	public LocalContainerEntityManagerFactoryBean energyEntityManager() {
		LocalContainerEntityManagerFactoryBean em
				= new LocalContainerEntityManagerFactoryBean();
		em.setDataSource(energyDataSource());
		em.setPackagesToScan(
				new String[] { "application.Database.EnergyDB.Models" });

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
	public DataSource energyDataSource() {

		DriverManagerDataSource dataSource
				= new DriverManagerDataSource();
		dataSource.setDriverClassName(
				env.getProperty("spring.energydb.driver"));
		dataSource.setUrl(env.getProperty("spring.energydb.url"));
		dataSource.setUsername(env.getProperty("spring.energydb.username"));
		dataSource.setPassword(env.getProperty("spring.energydb.password"));

		return dataSource;
	}

	@Primary
	@Bean
	public PlatformTransactionManager energyTransactionManager() {

		JpaTransactionManager transactionManager
				= new JpaTransactionManager();
		transactionManager.setEntityManagerFactory(
				energyEntityManager().getObject());
		return transactionManager;
	}
}