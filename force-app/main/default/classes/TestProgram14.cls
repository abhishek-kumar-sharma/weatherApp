/*Script to get all the Products Name(in a list) which were sold with one time
 Quantity(Opportunitylineitem) > 100 under their Opportunities(CLOSED WON only).*/
public with sharing class TestProgram14 {
	public static void getProductIdFromOLI()
	{
		List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
		List<Opportunity> oppList = new List<Opportunity>();
		oppList = [Select Name,StageName,HasOpportunityLineItem from Opportunity where HasOpportunityLineItem = true AND StageName ='Closed Won'];
		System.debug('Opportunity List - -------> '+oppList);
		if(oppList.size() > 0 )
		{
			oliList = [select Name,OpportunityId,Product2Id,Quantity from OpportunityLineItem where  Quantity > 100 AND OpportunityId IN: oppList ];
			System.debug('Oli having more than 100 quantity sold-----> '+oliList);
			
		}
	}
    
}