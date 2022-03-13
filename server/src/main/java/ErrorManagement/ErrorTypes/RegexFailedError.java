package ErrorManagement.ErrorTypes;

import java.util.regex.Pattern;

public class RegexFailedError extends ErrorType {
    private Pattern pattern;
    public RegexFailedError(Severity severity, String pattern){
        super(severity, pattern);

    }

    @Override
    public String generateErrorMessage() {
        String baseMessage = super.generateErrorMessage();
        String fullMessage = baseMessage + " When attempting to match with pattern " + value;
        return fullMessage;
    }
}
