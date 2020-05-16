public class AuraProgram1Controller {
@AuraEnabled
    public static String createAccountHandler(Account acc)
    {
       System.debug('------------>'+acc);
        if(acc.Name == '' || acc.Name == null)
        {
            return null;
        }
        else
        {
            upsert acc;
            return acc.Name;
        }
    }
}