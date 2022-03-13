package ErrorManagement.ErrorTypes;

public class NoPremiseError extends ErrorType {
    public NoPremiseError(ErrorType.Severity severity, String value){
        super(severity, value);
    }

    @Override
    public String generateErrorMessage() {
        String baseMessage = super.generateErrorMessage();
        String fullMessage = baseMessage + " No premise ID found for premise id: " + value;
        return fullMessage;
    }
}
