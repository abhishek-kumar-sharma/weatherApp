/*trigger on Case to create another case with subject "THIS Case is closed"+ old Case Subject 
and all the other fields as well whenver a case is getting closed with Account Name "Ajay".
trigger name - CaseTriggerForAjayAccount*/
public with sharing class CreateAnotherCaseHandler {
	public static void createCase(List<Case> caseList)
	{
		if(caseList.size() > 0 )
		{
			/*Finding the account Id of ajay*/
			Account accObj = new Account();
			accObj = [select Name from Account where Name = 'Ajay'];
			
			List<Case> newCaseList = new List<Case>();
			/*Checking the account id from caseList*/
			for(Case caseObj : caseList)
			{
				if(caseObj.AccountId == accObj.Id && caseObj.Status == 'Closed')
				{
					Case newCaseObj = new Case();
					newCaseObj.Subject = 'THIS Case is closed ' + caseObj.Subject; 
					newCaseObj.AccountId = caseObj.AccountId;
					newCaseObj.Status = caseObj.Status;
					newCaseObj.Priority = caseObj.Priority;
					newCaseList.add(newCaseObj);
				}
			}
			/*Inserting the new cases*/
			try
			{
				insert newCaseList;
				System.debug('---------->new case list ------> '+newCaseList);
			}
			catch(DMLException de)
			{
				System.debug(de.getMessage());
			}
		}
		else
		{
			System.debug('NULL CASE LIST RECIEVED');
		}
	}
    
}