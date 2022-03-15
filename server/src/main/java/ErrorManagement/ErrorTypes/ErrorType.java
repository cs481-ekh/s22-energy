package ErrorManagement.ErrorTypes;

public abstract class ErrorType {
    public enum Severity{
        WARNING,
        CRITICAL
    }
    protected Severity severity;
    protected String value;

    public ErrorType(Severity severity, String value){
        this.severity = severity;
        this.value = value;
    }
    public String generateErrorMessage(){
        String baseMessage = "[" + severity.toString() + " " + getClass().getSimpleName() + "] ->";
        return baseMessage;
    }
    public Severity getSeverity(){
        return severity;
    }
}
