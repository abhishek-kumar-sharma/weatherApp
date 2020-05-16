public class Challange1VFController {
    public List<Account> accList {set;get;}
    public String delRow{set;get;}
    
    public Challange1VFController()
    {
        fetchJob();
    }
    
    public void fetchJob()
    {
        accList = [select Name,Type,Industry,Fax,Owner.Name from Account limit 100];
        if(accList.size() > 0 )
        {
            System.debug('Data loaded') ;
        }
        else
        {
            System.debug('Unable to load data');
        }
    }
    
    public PageReference deleteHandler()
    {
        delRow = ApexPages.currentPage().getParameters().get('DelRowAccId');
        System.debug('---------------> Delete Account Id '+delRow);
        if(delRow != null)
        {
            System.debug('--------- if block'+delRow);
        }
        else
        {
            System.debug('Null Id recieved ........ Unable to Delete the Account');
        }
        
        fetchJob();
        return null;
    }
    
}