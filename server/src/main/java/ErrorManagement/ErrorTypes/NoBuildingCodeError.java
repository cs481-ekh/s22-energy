package ErrorManagement.ErrorTypes;

public class NoBuildingCodeError extends ErrorType{
    public NoBuildingCodeError(ErrorType.Severity severity, String value){
        super(severity, value);

    }

    @Override
    public String generateErrorMessage() {
        String baseMessage = super.generateErrorMessage();
        String fullMessage = baseMessage + " When looking up building code: " + value;
        return fullMessage;
    }
}
