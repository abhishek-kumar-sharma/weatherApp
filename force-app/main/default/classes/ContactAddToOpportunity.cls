public with sharing class ContactAddToOpportunity {
    public static void conOpportunityAdd(List<Opportunity> oppList)
    {
    	if(oppList.size() > 0)
    	{
    		/*getting account id of opportunity*/
    		 
    		Set<Id> oppIdSet = new Set<Id>();
    		for(Opportunity oppTemp : oppList)
    		{
    			oppIdSet.add(oppTemp.AccountId);
    		}
    		System.debug('Opportunity Id set  -----> '+oppIdSet);
    		
    		/*fetching all the account related to opportunity accountId*/
    		
  			List<Contact> conList = new List<Contact>();
  			conList = [select Name,AccountId from Contact where AccountId IN: oppIdSet ];
  			if(conList.size() > 0)
  			{
  				System.debug('-----------------------Contact fecthed------------------------');
  				System.debug(conList);
  				
  				//creating list for opportunity contact role and copying all the contact to it.
  				List<OpportunityContactRole> ocrList = new List<OpportunityContactRole>();
  				for(Opportunity opTemp : oppList)
  				{
  					for(Contact conTemp : conList)
	  				{
	  					OpportunityContactRole ocrObj = new OpportunityContactRole();
	  					ocrObj.ContactId = conTemp.Id;
	  					ocrObj.OpportunityId = opTemp.Id;//required field 
	  					ocrObj.Role = 'Other';
	  					ocrList.add(ocrObj);
	  				}
  				}
  				insert ocrList;
  				
  			}
  			
    		
    	}
    	else
    	{
    		System.debug('------------------> Null Opportunity List recieved <-------------------');
    	}
    }
}