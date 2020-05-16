public class testClass {
	public static void accMethod()
	{
		List<Account> accList=new List<Account>();//can contain duplicate data
		Set <Account> accset = new Set<Account>();//not containt duplicate data
		for(integer i=0;i<20;i++)
		{
		    Account ac=new Account();
		    ac.Name='TEST NAME'+i;
		    ac.Phone='123456789'+i;
		    ac.Industry='Banking';
		    ac.Type='Other';
		    accList.add(ac);
		    System.debug('Account--->'+accList);
		}
		insert accList;
		System.debug('Account List--->'+accList);
		
	}
    
}