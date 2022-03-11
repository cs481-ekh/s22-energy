package ErrorManagement;

public abstract class ManagmentStrategy {
    private ErrorManager manager;

    public void runManagementCycle(Error error){
        manager.addError(error);
        error.modifyMangementState(manager);


    }
}
