public class conAccountlookupcontroller {
    
   /* @AuraEnabled
    public static List<Account> loadAccount_Apex()
    {
        List<Account> accList = new List<Account>();
        accList = [select Id,Name from Account limit 100];
        return accList;
    }*/
    @AuraEnabled
    public static void createContact_Apex(Contact con)
    {
        System.debug('Recieved Con Data ---> '+con);
        if(con.LastName != 'null' || con.LastName != '')
        {
            try
            {
                upsert con;
            }
            catch(DMLException ex)
            {
                System.debug('DML Exception --> '+ex.getMessage());
            }
        }
    }
    
}