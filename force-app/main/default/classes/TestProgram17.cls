/*Create several Accounts and Opportunites and products.
 Write a Script to get all the Accounts having more than 2 Opportunites with Closed Won.	*/
public with sharing class TestProgram17 {
	
	//Method to get data as script question
	public static void getData()
	{
		List<Opportunity> oppList = new List<Opportunity>();
		oppList = [select Name,AccountId,StageName from Opportunity where AccountId != null AND StageName ='Closed Lost'];
		System.debug('------> '+oppList);
		
		map<Id,Integer> accountIdVsOpportunity = new map<Id,Integer>();
		for(Opportunity oppTemp : oppList)
		{
			//System.debug(oppTemp.AccountId);
			if(!accountIdVsOpportunity.containsKey(oppTemp.AccountId))
			{
				accountIdVsOpportunity.put(oppTemp.AccountId,1);
			}
			else
			{
				Integer i = accountIdVsOpportunity.get(oppTemp.AccountId);
				//System.debug(i);
				i++;
				//System.debug(i);
				accountIdVsOpportunity.put(oppTemp.AccountId,i);
				
			}
		}
		System.debug('map values --> '+accountIdVsOpportunity);
		
		Set<Id> accIdSet = new Set<Id>();
		for(Opportunity oppTemp : oppList)
		{
			if(accountIdVsOpportunity.containsKey(oppTemp.AccountId))
			{
			Integer temp = accountIdVsOpportunity.get(oppTemp.AccountId);
			//System.debug('Temp value ---> '+temp);
			if(temp >= 2)
			{   
				accIdSet.add(oppTemp.AccountId);
			}
			}
		}
		List<Account> accList =new List<Account>();
		accList = [select Name from Account where Id IN: accIdSet];
		System.debug('Account List Having more than 2 opp as closed lost '+accList);
		
	}
	
	
	//Method to create data
	public static void createData()
	{
		List<Account> accList = new List<Account>();
		List<Opportunity> oppList = new List<Opportunity>();
		List<Product2> proList = new List<Product2>();
		
		//Account creation
		for(Integer i=0;i<10;i++)
		{
			Account accObj = new Account();
			accObj.Name = 'Test 17 P '+i;
			accList.add(accObj);
		}
		try
		{
			insert accList;
			System.debug('----------> '+accList);
		}
		catch(DMLException de)
		{
			System.debug(de.getMessage());
		}
		
		//Opportunity creation
		for(Integer i=0;i<10;i++)
		{
			Opportunity oppObj = new Opportunity();
			oppObj.Name = 'Test 17 P '+i;
			oppObj.AccountId = accList[i].id;
			oppObj.CloseDate = date.today();
			oppObj.StageName = 'Closed Lost';
			oppList.add(oppObj);
		}
		try
		{
			insert oppList;
			System.debug('----------> '+oppList);
		}
		catch(DMLException de)
		{
			System.debug(de.getMessage());
		}
		///
		List<Opportunity> newOpp = new List<Opportunity>();
		for(Integer i=0;i<10;i++)
		{
			Opportunity oppObj = new Opportunity();
			oppObj.Name = 'Test 17 P2 '+i;
			oppObj.AccountId = accList[i].id;
			oppObj.CloseDate = date.today();
			oppObj.StageName = 'Closed Lost';
			newOpp.add(oppObj);
		}
		try
		{
			insert newOpp;
			System.debug('----------> '+newOpp);
		}
		catch(DMLException de)
		{
			System.debug(de.getMessage());
		}
		
		//Product creation
		for(Integer i=0;i<10;i++)
		{
			Product2 proObj = new Product2();
			proObj.Name = 'Test 17 P '+i;
			proObj.IsActive = true;
			proList.add(proObj);
		}
		try
		{
			insert proList;
			System.debug('----------> '+proList);
		}
		catch(DMLException de)
		{
			System.debug(de.getMessage());
		}
		
		
	}
	
    
}