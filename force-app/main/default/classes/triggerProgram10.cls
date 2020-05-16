public with sharing class triggerProgram10 {
    
    public static void campHandler(List<Campaign> campList)
    {
    	if(campList.size() > 0)
    	{
    		System.debug('Compaign list ------>  '+campList);
    		
    		//creating Id set for recived campign list
    		Set<Id> campIdSet = new Set<Id>();
    		for(Campaign campTemp : campList)
    		{
    			if(campTemp.Status == 'Completed')
    			{
    				campIdSet.add(campTemp.Id);
    			}
    		}//end of for loop
    		System.debug('ID set of campaign -------> '+campIdSet);
    		
    		
    		//fetching the opportunity on Id set  of campaign list 
    		List<Opportunity> oppList = new List<Opportunity>();
    		oppList=[select Name,StageName,CampaignId,HasOpportunityLineItem from Opportunity where CampaignId IN: campIdSet ];   
    		System.debug('------------------------------------------------------------------------------;');
    		System.debug(oppList);
    		
    		//changing the opportunity stage
    		if(oppList.size() > 0)
    		{
    				for(Campaign comp : campList)
    				{
    					for(Opportunity oppTemp : oppList)
    					{
    						if(oppTemp.CampaignId == comp.Id)
    						{
    							if(oppTemp.HasOpportunityLineItem == false)
    							{
    								oppTemp.StageName = 'Closed Lost';
    							}
    							else 
    							{
    								oppTemp.StageName = 'Closed won';
    							}
    						}
    					}
    				}	
    				upsert oppList;
    		}
    		else
    		{
    			System.debug('===================> Null opportunity list recived');
    		}
    		
    	}
    	else
    	{
    		System.debug('Null list of compaign recived =-------------=> '+campList);
    	}
    }
}