/*Script to get all the Accounts having more than 2 Oppotunity Line Items in their Opportunity.
Written By Abhishek kumar sharma
Date 20 - JAN - 2018*/


public with sharing class GetAccOpportunity {
	public static void getAccountOpportunity()
	{
		
		/*Fetching all the opportunity having opportuntiy line item and Account ID field not null */
		List <Opportunity> oppList = new List<Opportunity>();
		oppList = [select Name,AccountId,HasOpportunityLineItem from Opportunity where AccountId != null AND HasOpportunityLineItem = true];
		System.debug('list--->'+oppList);
		
		
		/*Creating the ID set of opportunity*/
		Set<Id> oppIdSet = new Set<Id>();
		for(Opportunity oppTemp : oppList)
		{
			oppIdSet.add(oppTemp.id);
		}
		System.debug('Opp id set ---> '+oppIdSet);
		
		/*Fetching the opportunity line item via opportunity id set*/
		List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
	    oliList = [select Name,OpportunityId from OpportunityLineItem where OpportunityId IN:oppIdSet];
	    System.debug('------>'+oliList);
	    
	    for(Opportunity oppTemp : oppList)
	    {
	    	Integer noOfOli = 0 ;
	    	for(OpportunityLineItem oliTemp : oliList)
	    	{
	    		if(oppTemp.Id == olitemp.OpportunityId)
	    		{
	    			
	    		}
	    	}
	    }
	    
	    
	    
	    
		
		
		
		
		
	}
    
}