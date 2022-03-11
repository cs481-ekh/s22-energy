package application.Model;

public class Error {

    private String errorMessage;
    private Errors errorType;

    /**
     * Enumeration of possible error types.
     */
    public enum Errors {
        MISSINGPREMISE("WARNING"),
        DATAFORMAT("CRITICAL"),
        NULLEXCEPTION("CRITICAL"),
        NOBUILDING("WARNING"),
        FAILEDREGEX("CRITICAL"),
        DATEFORMAT("CRITICAL");

        // Keeps track of severity
        private String severity;

        Errors(String errorSeverity) {
            severity = errorSeverity;
        }
        public String getSeverity() {
            return severity;
        }
    }

    public Error() {

    }

    public Error(String errorMessage, Errors errorType) {
        this.errorMessage = errorMessage;
        this.errorType = errorType;
    }

    /**
     * Sets the error message and error type
     * @param errorMessage - Error message
     * @param errorType - Type of error
     */
    public void setErrorMessage(String errorMessage, Errors errorType) {
        this.errorMessage = errorMessage;
        this.errorType = errorType;
    }

    /**
     * Returns the error message
     * @return - error message
     */
    public String getErrorMessage() {
        return errorMessage;
    }
}

