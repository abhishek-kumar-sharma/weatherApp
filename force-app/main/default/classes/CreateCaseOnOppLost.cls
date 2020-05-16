/*Write a trigger on Opportunity to create a new Case with all case fields should 
have default values whenever an Opporutnity is getting closed lost.
trigger name --- CreateCaseOnoppCloseLost*/
public with sharing class CreateCaseOnOppLost {
  public static void createCase(List<Opportunity> oppList)
  {
  	if(oppList.size() > 0 )
  	{
  		List<Case> caseList = new List<Case>();
  		for(Opportunity oppTemp : oppList)
  		{
  			if(oppTemp.StageName == 'Closed Lost')
  			{
  				Case caseObj = new Case();
  				caseObj.AccountId =oppTemp.AccountId;
  				caseObj.Status = 'Closed';
  				caseObj.Subject = 'Opportunity closed lost';
  				caseList.add(caseObj);
  			}
  		} 
  		try
  		{
  			insert caseList;
  			System.debug('---------> Case List <------- '+caseList);
  		}
  		catch(DMLException de)
  		{
  			System.debug(de.getMessage());
  		}
  	}
  	else
  	{
  		System.debug('Null oppList ');
  	}
  }  
}