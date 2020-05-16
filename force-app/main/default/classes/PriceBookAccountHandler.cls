public with sharing class PriceBookAccountHandler {
	public static void managePriceBook(List<Opportunity> oppList)
	{
		if(oppList.size() > 0 )
		{
			Set<Id> accIdSet = new Set<Id>();
			Set<Id> pbkIdSet = new Set<Id>();
			
			/*ID set for Account and Pricebook from opportuntiy list*/
			for(Opportunity oppTemp : oppList)
			{
				if(oppTemp.AccountId != null)
				{
					accIdSet.add(oppTemp.AccountId);
					pbkIdSet.add(oppTemp.Pricebook2Id);
				}
			}
			System.debug('Account ID -----------------> '+accIdSet);
			System.debug('Pricebook ID -----------------> '+pbkIdSet);
			
			/*fetching the data from id sets*/
			List<Account> accList = new List<Account>();
			accList = [select Working_in__c from Account where Id IN: accIdSet];
			List<PriceBook2> pbkList = new List<PriceBook2>();
			pbkList = [select Name from PriceBook2 where Id IN: pbkIdSet ];
			System.debug('Account List updated -------> '+accList);
			System.debug('Price book entry updated --> '+pbkList);
			
			
			if(accList.size() > 0 && pbkList.size() > 0 )
			{
				  map<Id,String> accMap = new map<Id,String>();
				  map<Id,String> pbkMap = new map<Id,String>();
				  
				  for(Account accTemp : accList)
				  {
				  	accMap.put(accTemp.Id,accTemp.Working_in__c);
				  }
				  System.debug('Account map ----> '+accMap);
				  for(PriceBook2 pbkTemp : pbkList)
				  {
				  	pbkMap.put(pbkTemp.Id,pbkTemp.Name);
				  }
				  System.debug('Price book map ---> '+pbkMap);
			
				  for(Opportunity oppTemp : oppList)
				  {
				  	System.debug('loop ----> '+oppTemp.AccountId +'      l '+oppTemp.PriceBook2Id);
				  	if(!accMap.get(oppTemp.AccountId).contains(pbkMap.get(oppTemp.PriceBook2Id)))
				  	{
				  		oppTemp.addError('Work in account filed not matched');
				  	}
				  }
				  
				
			}
			else
			{
				System.debug('Null Account List Recieved');
			}
	  }
	   else
	    {
		   System.debug('---------------->NULL LIST OF OPPORTUNITY<-------------');
		}  
	}
    
}