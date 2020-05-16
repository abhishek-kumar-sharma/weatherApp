public class Program3 {
    
    
    public static void accConLookup()
    {
	    List <Account> accList = new List<Account>();
	    List<Contact> conList  = new List<Contact>();
	    
	    //loop for creating new account
	    for(integer i=0;i<10;i++)
	    {
	    	Account accObj = new Account();
	    	accObj.Name='abhishek'+i;
	    	accObj.Site='http://www.djangoForce.com'+i;
	    	accObj.Industry='Biotechnology';
	    	accObj.Type='Other';
	    	accList.add(accObj);
	    	System.debug('Created Item ---->  '+i);
	    } 
    insert accList;
    
    //loop for creating lookup with contact and account
    
    for(integer i=0;i<10;i++)
    {
    	Contact conObj = new Contact();
    	ConObj.LastName = 'hell test'+i;
    	conObj.Email='test@cloudanalogy.com';
    	conObj.AccountId=accList[i].id;
    	System.debug('Account Id ---->  '+conObj.AccountId);
    	conObj.Title='Mr.';
    	conObj.Department='delevlopment';
    	conList.add(conObj);
    	System.debug('Status ---->  '+i);
    }
    
    insert conList;
	}
}