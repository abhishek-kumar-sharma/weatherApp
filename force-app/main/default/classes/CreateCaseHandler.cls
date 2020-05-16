/*Trigger on account to create a default Contact, Case, Opporunity and Contact Role.
 whenever an Account is created with Number of Employees > 100.
  Make sure the Contact is in contact field of Case as well as related to Opporutnity inn Contact Role.
  
  trigger Name - TestProgram16 o account object
  Written by Abhishek Kumar sharma
  date 29-01-2018*/
public with sharing class CreateCaseHandler {
    public static void createCase(List<Account> accList)
    {
    	if(accList.size() > 0 )
    	{
    		System.debug('------------Account List'+accList);
    		System.debug('--------------> '+acclist.size());
    		
    		/*Accessing the no of employee field of account */
    		Set<Id> accIdSet = new Set<Id>();
    		for(Account accTemp : accList)
    		{
    			if(accTemp.NumberOfEmployees > 100)
    			{
    				accIdSet.add(accTemp.Id);
    			}
    		}
    		
    		if(accIdSet.size() > 0 )
    		{
    		
	    		/*Creating contact */
	    		List<Contact> conList = new List<Contact>();
	    		for(Integer i=0 ; i<accIdSet.size();i++)
	    		{
	    			Contact conObj = new Contact();
	    			conObj.LastName = 'Program 16 '+i;  
	    			conObj.AccountId = accList[i].Id;
	    			conList.add(conObj);
	    			
	    		}
	    		try
	    		{
	    			insert conList;
	    			System.debug('Contact List --------> '+conList);
	    		}
	    		catch(DMLException de)
	    		{
	    			System.debug(de.getMessage());
	    		}
	    		
	    		/*Creating cases */
	    		List<Case> caseList = new List<Case>();
	    		for(Integer i=0;i<accIdSet.size();i++)
	    		{
	    			Case caseObj = new Case();
	    			caseObj.ContactId = conList[i].Id;
	    			caseObj.AccountId = accList[i].Id;
	    			caseObj.Status = 'New';
	    			caseObj.Origin = 'Phone';
	    			caseList.add(caseObj);
	    		}
	    		try
	    		{
	    			insert caseList;
	    			System.debug('Case List -----> '+caseList);
	    		}
	    		catch(DMLException de)
	    		{
	    			System.debug(de.getMessage());
	    		}
	    		
	    		/*Creating opportunity */
	    		List<Opportunity> oppList = new List<Opportunity>();
	    		for(Integer i=0;i<accIdSet.size(); i++)
	    		{
	    			Opportunity oppObj = new Opportunity();
	    			oppObj.Name = 'Progarm 16 '+i;
	    			oppObj.StageName = 'Colsed Won';
	    			oppObj.CloseDate = System.now().date();  
	    			oppObj.AccountId = accList[i].Id;
	    			oppList.add(oppObj);
	    		}
	    		try
	    		{
	    			insert oppList;
	    			System.debug('Opportunity List -------> '+oppList);
	    		}
	    		catch(DMLException de)
	    		{
	    			System.debug(de.getMessage());
	    		}
	    		        
	    		/*Creating Conatct role of opportunity*/
	    		List<OpportunityContactRole> ocrList = new List<OpportunityContactRole>();
	    		for(Integer i=0; i<accList.size();i++)
	    		{
	    			OpportunityContactRole ocrObj = new OpportunityContactRole();
	    			ocrObj.ContactId = conList[i].Id;
	    			ocrObj.OpportunityId = oppList[i].Id;
	    			ocrList.add(ocrObj);
	    		}
	    		try
	    		{
	    			insert ocrList;
	    			System.debug('Opportunity contact role ----> '+ocrList);
	    		}
	    		catch(DMLException de)
	    		{
	    			System.debug(de.getMessage());
	    		}
    		}
    	}
    	else
    	{
    		System.debug('Null list recieved');
    	}
    }
}