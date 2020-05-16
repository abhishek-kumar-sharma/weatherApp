/*Trigger class for handling the OLI in opportuntiy
trigger name - maxCheckOpportunity
object name - Opportunity*/

/*
Count__c is a custom field on Opportunity object of roll up summary type
*/

public with sharing class CheckMaxOli {
    public static void oliCheckMax(List<Opportunity> oppList)
    {
    	if(oppList.size() > 0)
    	{
    		/*Checking opportuntiy line Items in opportunity if more than 2 than following error occured*/
    		for(Opportunity oppTemp : oppList)
    		{
    			if(oppTemp.Count__c > 2 )
    			{
    				oppTemp.addError('Maximum Two opportunity line item allowed ');
    			}
    		}    
    	}
    	else  
    	{
    		System.debug('NULL opportuntiy List recieved');
    	}
    }
}