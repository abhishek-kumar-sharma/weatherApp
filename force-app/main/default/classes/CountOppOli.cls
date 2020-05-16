/*Script to get all the Accounts having more than 2 Oppotunity Line Items in their Opportunity.
Written By Abhishek kumar sharma
Date 20 - JAN - 2018*/

/*Manual Work 
step 1 Goto org open setup.
step 2 open object manager->opportunity.
step 3 open field and relationship of opportunity and create a custom field 'count' of roll up summary type
Step 4 select the count in query and print the total no via following script
*/

public with sharing class CountOppOli  {
	public static void countOppProduct()
	{
		/*Fetching the opportunity whose accountID is not null*/
		List<Opportunity> oppList = new List<Opportunity>();
		oppList = [Select Name,AccountId,Count__c from Opportunity where AccountId != Null];
		
		if(oppList.size() > 0)
		{
			/*Creating set of accountId from opportunity list and matching the condition for OLI>2*/
			Set<Id> accIdSet = new Set<Id>();
			for(Opportunity oppTemp : oppList)
			{
				if(oppTemp.Count__c > 2)
				{
					accIdSet.add(oppTemp.AccountId);
				}
			}
			
			/*Fetching the account from opportuntiy Id set*/
			List<Account> accList = new List<Account>();
			accList = [Select Name from Account where Id IN:accIdSet];
			
			if(accList.size() > 0)
			{
				/*Printing the Account Name having more than two oli in opportunity*/
				System.debug('Account Name Having more than two opportunity Line Item in Opportunity  ');
				for(Account accTemp :accList)
				{
					System.debug(accTemp.Name);
				}
			}
			else
			{
				System.debug('Null Account List Recieved');
			}
		}
		else
		{
			System.debug('Null Opportuntiy list recieved');
		}
	}
    
}