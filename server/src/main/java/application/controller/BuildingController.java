package application.controller;

import application.Database.EnergyDB.Models.Building;
import application.Database.EnergyDB.Repo.JPARepository.BuildingRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.*;


@CrossOrigin("*")
@RestController
public class BuildingController {
    @Autowired
    BuildingRepo buildingRepo;

    /**
     * Gets all the buildings from the buildings database
     * @return list of usage that matched criteria.
     */
    @GetMapping(value = "/building")
    public List<Building> getBuildings(){

        List<Building> buildingResult = new ArrayList<>();
        Optional<List<Building>> buildings;

        // Runs query on db
        buildings = buildingRepo.getAllBuildings();

        // Gets the result
        if (buildings.isPresent()) {
            buildingResult = buildings.get();
        }
        return buildingResult;
    }
}
