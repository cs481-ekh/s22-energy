package ErrorManagement;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.List;

/**
 * Defines base interface for an error manager
 * @param <T> - Item that an error will hold.
 */
public abstract class ErrorManager<T> {

    protected final transient Logger logger = LoggerFactory.getLogger(getClass());

    /**
     * Adds an error to manage.
     * @param error - Error to add
     */
    public abstract void addError(Error<T> error);

    /**
     * Adds an error to manage
     * @param error - Adds an error to manage.
     * @param item - Item to keep track of
     */
    public abstract void addError(Error<T> error, T item);

}
