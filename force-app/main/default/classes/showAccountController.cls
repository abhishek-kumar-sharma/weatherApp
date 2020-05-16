/*VF page Name - VFProgram2*/
public class showAccountController {

    List<Account> accList;

    public List<Account> getaccList() {
        return accList;
    }
       
    public showAccountController()
    {
        accList=  [Select Name,Type,Industry,Fax from Account limit 1000];
    }
    
    
}