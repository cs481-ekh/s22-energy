package ErrorManagement.ErrorTypes;

public class DataValidationError extends ErrorType {
    private String dataType;

    public DataValidationError(Severity severity, String value, String dataType){
        super(severity, value);
        this.dataType = dataType;
    }

    @Override
    public String generateErrorMessage() {
        String baseMessage = super.generateErrorMessage();
        String fullMessage = baseMessage + " When parsing " + value + " to " + dataType;
        return fullMessage;
    }
}
