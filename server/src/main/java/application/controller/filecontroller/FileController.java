package application.controller.filecontroller;

import application.CSV.ElectricDemandParser;
import application.CSV.NaturalGasParser;
import application.CSV.SolarParser;
import application.Database.EnergyDB.Models.Building;
import application.Database.EnergyDB.Models.Usage;
import application.Database.EnergyDB.Repo.JPARepository.BuildingRepo;
import application.Database.EnergyDB.Repo.JPARepository.PremiseRepo;
import application.Database.EnergyDB.Repo.JPARepository.UsageRepo;
import application.Datasource;

import application.Model.Response;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.nio.file.Path;

@RestController
public class FileController {

    private static final Logger logger = LoggerFactory.getLogger(FileController.class);

    @Autowired
    private FileStorageService fileStorageService;

    @Autowired
    private UsageRepo usageRepo;
    @Autowired
    private PremiseRepo premiseRepo;
    @Autowired
    private BuildingRepo buildingRepo;

    @PostMapping("/uploadFile") // Add another parameter for Utility ID
    public Response<Usage> uploadFile(@RequestParam("file") MultipartFile file, @RequestParam String utilID) throws IOException {
        // Get the directory where the file was stored.
        String fileDir = fileStorageService.storeFile(file);
        Response<Usage> response = new Response<>();

        try {
            int utilityID = Integer.parseInt(utilID);
            // Initialize data source
            Datasource source = null;
            switch (utilityID) {
                case 1:
                    source = new NaturalGasParser(fileDir, utilityID, premiseRepo);
                    break;
                case 2:
                    source = new ElectricDemandParser(fileDir, utilityID, buildingRepo);
                    break;
                case 3:
                    break;
                case 4:
                    break;
                case 5:
                    source = new SolarParser(fileDir, utilityID);
                    break;
            }

            if (source != null) {
                try {
                    response = source.readData();
                } catch (Exception ex) {
                    logger.error("Error uploading" + fileDir + " " + ex.getMessage());
                }
                usageRepo.saveAll(response.getSuccess());
            } else {
                logger.error("Failed to initialize data source for utility id " + utilID);
            }
        }
        catch(Exception ex){
            logger.error("Exception occurred during parsing " + ex.getMessage());
        }
        return response;
    }

    @GetMapping("/downloadFile/{fileName:.+}")
    public ResponseEntity<Resource> downloadFile(@PathVariable String fileName, HttpServletRequest request) {
        // Load file as Resource
        Resource resource = null;
        try {
            resource = fileStorageService.loadFileAsResource(fileName);
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Try to determine file's content type
        String contentType = null;
        try {
            contentType = request.getServletContext().getMimeType(resource.getFile().getAbsolutePath());
        } catch (IOException ex) {
            logger.info("Could not determine file type.");
        }

        // Fallback to the default content type if type could not be determined
        if(contentType == null) {
            contentType = "application/octet-stream";
        }

        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(contentType))
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.getFilename() + "\"")
                .body(resource);
    }
}
