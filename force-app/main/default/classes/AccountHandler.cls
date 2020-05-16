public class AccountHandler{
		public static Account insertNewAccount(String param)
        {
            try
            {
                    List<Account> accList = new List<Account>();
                    Account acc = new Account();
                    acc.Name=param;
                	accList.add(acc);
                    insert acc;
               		return acc;
                    
             
            }
            catch(DmlException de)
            {
                System.debug('A DML exception has occurred: ' +
                de.getMessage());
                return null;
            }
            
        }
}