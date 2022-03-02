package application.Database.EnergyDB.Repo;

import java.util.Collection;
import java.util.List;
import java.util.Optional;
import java.util.function.Function;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.cdi.JpaRepositoryExtension;
import org.springframework.data.repository.query.FluentQuery.FetchableFluentQuery;

import application.Database.EnergyDB.Models.Building;

public interface BuildingRepo extends JpaRepository<Building, Integer> , BuildingRepoInterface {
   
    
 
    
}
