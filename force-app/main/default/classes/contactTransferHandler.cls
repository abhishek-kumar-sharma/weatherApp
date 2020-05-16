public with sharing class contactTransferHandler {
    public static void transferContact(List<Contact> conList)
    {
    	/*NULL check for contact list*/
    	if(conList.size() > 0 )
    	{
    		/* creating id set of account */
    		Set<Id> conIdSet = new Set<Id>();
    		for(Contact conTemp : conList)
    		{
    			conIdSet.add(conTemp.Id);
    		}
    		
    		/*Fetching single account id i.e. 'Cloud Aanlogy' */
    		String accId = [select Id from Account where Name =: 'Cloud Analogy'].Id;
    		if(accId != null)
    		{    		
	    		/*Adding contact to Account */
	    		for(Contact conTemp : conList)
	    		{
	    			conTemp.AccountId = accId;
	    		}
    		}
    		/*insert conList; no need data is avialable in pipeline so after trigger execution data will automatically inserted*/
    	}
    	else
    	{
    		System.debug('Null Conatct list recieved');
    	}
    }
}