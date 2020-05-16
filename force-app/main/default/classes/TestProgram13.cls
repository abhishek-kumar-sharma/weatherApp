/*Script to get all the Accounts having more than 2 Cases marked as Status closed.*/

public with sharing class TestProgram13 {
	public static void accountHavingTwoCase()
	{
		List<Case> caseList = new List<Case>();
		caseList = [Select CaseNumber,AccountId,Status from Case where AccountId != null AND Status ='Closed'];
		map<Id,Integer> accountIdVsCases = new map<Id,Integer>();
		
		/*creating map of accountid and no of cases*/
		for(Case caseObj  :caseList)
		{
			if(!accountIdVsCases.containsKey(caseObj.AccountId))
			{
				accountIdVsCases.put(caseObj.AccountId,1);
			}
			else
			{
				Integer c = accountIdVsCases.get(caseObj.AccountId);
				c++;
				accountIdVsCases.put(caseObj.AccountId,c);
			}
		}
		
		/*getting the account id having morwe than 2 cases*/
		Set<Id> accIdSet = new Set<Id>();
		
		for(Case caseObj : caseList)
		{
			if(accountIdVsCases.get(caseObj.AccountId) > 2)
			{
				accIdSet.add(caseObj.AccountId);		
			}
		}
		/*Printing the  account name*/
		List<Account> accFinalList = new List<Account>();
		accFinalList = [Select Name  from Account where Id IN: accIdSet];
		System.debug('Account having more than 2 closed cases ----> '+accFinalList);
		
	}
	
	/*method to create Account and cases*/
	public static void createData()
	{
		List<Account> acclist = new List<Account>();
		List<Case> caseList = new List<Case>();
		
		for(Integer i=0;i<10;i++)
		{
			Account accObj = new Account();
			accObj.Name = 'Case Account'+i;
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
		for(Integer i=0;i<10;i++)
		{
			Case caseObj = new Case();
			caseObj.AccountId = accList[i].id;
			caseObj.Status = 'Closed';
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
    
}