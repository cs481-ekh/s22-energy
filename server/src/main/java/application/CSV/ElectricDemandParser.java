package application.CSV;

import application.Database.EnergyDB.Models.Building;
import application.Database.EnergyDB.Models.Usage;
import application.Database.EnergyDB.Repo.JPARepository.BuildingRepo;
import application.Model.Error;
import application.Model.Response;
import com.opencsv.exceptions.CsvValidationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.zip.DataFormatException;

public class ElectricDemandParser extends CsvParser {
    private final BuildingRepo buildingRepo;

    public ElectricDemandParser(String csvPath, BuildingRepo repo) throws FileNotFoundException {
        super(csvPath);
        buildingRepo = repo;
    }

    private Map<Integer, Building> generateHeaderMap(Response response) throws CsvValidationException, IOException {
        Pattern headerPattern = Pattern.compile("Utility\\.([a-zA-Z_]+)?(\\d{3})", Pattern.CASE_INSENSITIVE);

        List<String> rowHeaders = List.of(reader.readNext());
        Map<Integer, Building> mappedHeaders = IntStream.range(0, rowHeaders.size())
                .boxed()
                .collect(Collectors.toMap(index -> index + 1, index -> {
                    String listValue = rowHeaders.get(index);
                    Matcher match = headerPattern.matcher(listValue);
                    Building building = new Building();
                    if (match.find()) {
                        String buildingCode = match.group(2);
                        Optional<Building> queriedBuilding = buildingRepo.findById(buildingCode);
                        if (queriedBuilding.isEmpty()) {
                            String errorMessage = "Building code not found for building code " + buildingCode;
                            logger.error(errorMessage);
                            Error error = new Error(errorMessage, Error.Errors.NOBUILDING);
                            response.setError(error);
                        } else {
                            building = queriedBuilding.get();
                        }
                    } else {
                        String errorMessage = "Regex match failed for " + listValue;
                        logger.error(errorMessage);
                        Error error = new Error(errorMessage, Error.Errors.FAILEDREGEX);
                        response.setError(error);
                    }
                    return building;
                }));
        lineNumber++;
        return mappedHeaders;
    }

    private Timestamp getTimestamp(Response response, String date, Error error, int rowNumber) {
        Timestamp stamp = null;
        try {
            DateFormat format = new SimpleDateFormat("MM/dd/yy HH:mm");
            Date time = format.parse(date);
            stamp = new Timestamp(time.getTime());
        } catch (ParseException ex) {
            String errorMessage = "Failed to parse date " + date + " at row " + lineNumber + " column " + rowNumber;
            logger.error(errorMessage);
            error.setErrorMessage(errorMessage, Error.Errors.DATEFORMAT);
        }
        return stamp;
    }

    @Override
    public Response readData() throws CsvValidationException, IOException {
        Response response = new Response();

        Map<Integer, Building> headersMap = generateHeaderMap(response);

        String[] rowData = null;
        while ((rowData = reader.readNext()) != null) {
            String date = rowData[0];
            Error errorDate = new Error();
            final int DATE_ROW = 1;
            Timestamp stamp = getTimestamp(response, date, errorDate, DATE_ROW);
            if (errorDate.hasError()) {
                response.setError(errorDate);
            }
            for (int i = 1; i < rowData.length; i++) {
                Error error = new Error();
                Usage usage = new Usage();
                usage.timestamp = stamp;
                Building building = headersMap.get(i);
                String buildingCode = building.buildingCode;
                usage.buildingCode = buildingCode;
                int rowNumber = i + 1;
                String data = rowData[i];
                if (!data.equals("") && !data.equals("NULL")) {
                    try {
                        double utilityUsage = Double.parseDouble(data);
                        BigDecimal result = new BigDecimal(utilityUsage);
                        usage.utilityUsage = result;
                    } catch (NumberFormatException exception) {
                        String errorMessage = "Failed to parse usage to long " + data + " at row " + lineNumber + " column " + rowNumber;
                        logger.error(errorMessage);
                        error.setErrorMessage(errorMessage, Error.Errors.DATAFORMAT);
                    }

                }
                if (error.hasError()) {
                    error.setErrorUsage(usage);
                    response.setError(error);
                } else {
                    response.addSuccess(usage);
                }
            }
            lineNumber++;
        }
        return response;
    }
}
