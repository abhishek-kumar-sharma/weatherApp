public with sharing class TestProgram16 {
	/*Dummy data insertion*/
	
	public static void createCases()
	{
		List<Account> accList =new List<Account>();
		List<Case> caseList = new List<Case>();
		
		for(Integer i=0 ; i<10 ;i++)
		{
			Account accObj = new Account();
			accObj.Name = 'Case Test '+i;
			accObj.NumberOfEmployees  = 100;
			accList.add(accObj);
			
		}
		try
		{
		insert accList;
		}
		catch(DMLException de)
		{
			System.debug(de.getMessage());
		}
		
		
		for(Integer i = 0;i< 10;i++)
		{
			Case caseObj = new Case();
			caseObj.AccountId = accList[i].Id;     
			caseObj.Status = 'New';
			caseObj.Origin = 'Email';
			caseList.add(caseObj);  
		}
		
		try
		{
			insert caseList;
		}
		catch(DMLException de)
		{
			System.debug(de.getMessage());
		}
		
	}
	
	//fetching all the cases having more than 100 No of employee in account 
	public static void fetchCase()
	{
		
		List<Account> accList = new List<Account>();
		accList = [select Name,NumberOfEmployees from Account where NumberOfEmployees > 100];
		
		if(accList.size() > 0 )
		{
			List<Case> caseList = new List<Case>();
			caseList = [select CaseNumber,AccountId,Status,Priority from Case where AccountId IN: accList];
			for(Case caseObj : caseList)
			{
				System.debug('Case'+caseObj);
			}
		}
		else
		{
			System.debug('Unable to fetch Account');
		}
		
	}
    
}