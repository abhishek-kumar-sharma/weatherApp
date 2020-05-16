/**
 * Created by ABHISHEK on 09-09-2019.
 */

public class AccountLookUpController {
    public List<Account> accList{get;set;}
    public AccountLookUpController()
    {
        accList = new List<Account>();
        accList = [SELECT ID,Name From Account LIMIT 100];
    }
}