package ErrorManagement;

import java.util.ArrayList;
import java.util.List;

public interface ErrorManager<T> {
   public List<Error<T>> getErrors();

   public void addError(Error<T> error);

   public void printErrors();
   
   public void runManagement();
}
