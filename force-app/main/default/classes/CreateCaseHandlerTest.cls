/*trigger on Opportunity to create a new Case with "Subject" and "Description" fields from Opportunity 
(all other case field should have default values) whenever an Opporutnity is getting closed lost.
Trigger name -- CreateCaseOnCloseLostOpp*/
public with sharing class CreateCaseHandlerTest {
	public static void createCases(List<Opportunity> oppList)
	{
		if(oppList.size() > 0 )
		{
			List<Case> caseList = new List<Case>();
			for(Opportunity oppTemp : oppList)
			{
				if(oppTemp.StageName == 'Closed Lost')
				{
					Case caseObj  = new Case();
					caseObj.Subject =oppTemp.Name + '  Subject ';
					caseObj.Description = oppTemp.Description;
					caseList.add(caseObj);
				}
			}
			try
			{
				insert caseList;
				System.debug('CAse list ------------------> '+caseList);
			}
			catch(DMLException de)
			{
				System.debug(de.getMessage());
			}
		}
		else
		{
			System.debug('null list of opportunity recieved');
		}
		
	}
    
}