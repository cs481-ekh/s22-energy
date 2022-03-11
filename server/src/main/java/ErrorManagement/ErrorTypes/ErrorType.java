package ErrorManagement.ErrorTypes;

public abstract class ErrorType {
    public enum Severity{
        WARNING,
        CRITICAL
    }
    public Severity severity;
    public abstract String generateErrorMessage();
    public Severity getSeverity(){
        return severity;
    }
}
