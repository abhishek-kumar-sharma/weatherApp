public class CreateAccountController {
    public Account acc{get;set;}
    
    public CreateAccountController()
    {
        acc = new Account();

    }
    public PageReference save()
    {
        try
        {
            insert acc;
            System.debug('----------------------> '+acc);
        }
        catch(Exception de)
        {
            System.debug(de.getMessage());
        }
        
        return null;
    }
    public PageReference cancel()
    {
        return null;
    }

}