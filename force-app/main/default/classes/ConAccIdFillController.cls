//Controller of vf page
//Page Name VFProgram4
/*VFPage controller
Create a page with a custom mandatory field (Contact) which automatically fills the another text field (Contact's account name) 
Page Name - VFProgram4
*/
public class ConAccIdFillController {
    
    public String conName{set;get;}
    public String setRes{set;get;}
    
    public void searchAccount()
    {
        System.debug('---------------> '+conName);
        try
        {
            setRes = [select Account.Name,LastName from contact where LastName like: conName].Account.Name;
            System.debug('----------------------- > Account name '+setRes);
       }
        catch(Exception de)
        {
            System.debug(de.getCause()+'  '+de.getMessage());
            setRes = ' ';
            ApexPages.addMessage( new ApexPages.message(ApexPages.Severity.WARNING,'No Account found'));
        }
        
    }
}