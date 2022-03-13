package ErrorManagement.ErrorTypes;

public class DateFormatValidationError extends ErrorType {
    public DateFormatValidationError(ErrorType.Severity severity, String value){
        super(severity, value);
    }

    @Override
    public String generateErrorMessage() {
        String baseMessage = super.generateErrorMessage();
        String fullMessage = baseMessage + " When trying to convert " + value + " to timestamp";
        return fullMessage;
    }
}
