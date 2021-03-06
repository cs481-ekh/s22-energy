package application.controller.filecontroller;


import application.CSV.*;

import application.Database.EnergyDB.Models.Usage;
import application.Database.EnergyDB.Repo.JPARepository.BuildingRepo;
import application.Database.EnergyDB.Repo.JPARepository.PremiseRepo;
import application.Database.EnergyDB.Repo.JPARepository.UsageRepo;
import application.Datasource;

import application.Model.Response;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;

@CrossOrigin("*")
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

    /**
     * Uploads a csv file to the database using one of the specific parsers.
     *
     * @param file   - File sent by front end to parse.
     * @param utilID - The utility id to parse
     * @return A response objects
     * @throws IOException
     */
    @PostMapping(value = "/uploadFile", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    // Add another parameter for Utility ID
    public ResponseEntity<Response> uploadFile(@RequestParam("file") MultipartFile file, @RequestParam String utilID) throws IOException {
        // Get the directory where the file was stored.
        String fileDir = fileStorageService.storeFile(file);
        Response<Usage> response = new Response<>();
        ResponseEntity<Response> controllerResponse = null;

        try {
            // Initialize data source
            Datasource source = null;
            switch (utilID) {
                case "1":
                    source = new NaturalGasParser(fileDir, 1, premiseRepo);
                    break;
                case "2D":
                    source = new ElectricDemandParser(fileDir, 2, buildingRepo);
                    break;
                case "2S":
                    source = new SmallElectricParser(fileDir, 2, premiseRepo);
                    break;
                case "3":
                    // Steam parser
                    break;
                case "4":
                    source = new GeoThermalParser(fileDir, 4, buildingRepo);
                    break;
                case "5":
                    source = new SolarParser(fileDir, 5);
                    break;
            }

            // Makes sure one of the cases was hit.
            if (source != null) {
                // Read data from the data source.
                response = source.readData();

                List<Usage> successList = response.getSuccess();

                // Make sure the file was actually parsed
                if (successList.isEmpty()) {
                    throw new FileUploadException("No successes were found for file " + fileDir);
                }
                // Upload succesful usages.
                for (Usage u : successList) {
                    usageRepo.upsertUsage(u);
                }
            } else {
                throw new FileUploadException("Failed to initialize data source for utility id " + utilID);
            }
        } catch (Exception ex) {
            logger.error("Exception occurred during parsing file " + fileDir + " " + ex.getMessage());
            controllerResponse = ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
        finally {
            controllerResponse = controllerResponse == null ? ResponseEntity.ok(response) : controllerResponse;
            return controllerResponse;
        }
    }

    /**
     * Gives ability to download file
     *
     * @param fileName - File name to download
     * @param request  - The request to download the item.
     * @return - The requested resource.
     */
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
        if (contentType == null) {
            contentType = "application/octet-stream";
        }

        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(contentType))
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.getFilename() + "\"")
                .body(resource);
    }
}
