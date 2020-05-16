/*Trigger class to manage chasma sold
trigger name - TotalChasmaSold
Date - 25 -JAN-2018*/

public with sharing class ChasmaSoldHandler {
	public static void soldManager(List<OpportunityLineItem> oliList )
	{
		if(oliList.size() > 0 )
		{
			//creating opp id set for checking opp stage
			Set<Id> oppIdSet = new Set<Id>();
			for(OpportunityLineItem oliTemp : oliList)
			{
				oppIdSet.add(oliTemp.OpportunityId);
			}
			
			//fetching opportunity on basic of opp id and stage close won
			List<Opportunity> oppList = new List<Opportunity>();
			oppList = [select Name,StageName from Opportunity where Id IN: oppIdSet AND StageName = 'Closed Won'];
			
			if(oppList.size() > 0 )
			{
				//Product fetching
				Product2 proObj = new Product2();
				proObj = [select Name,Total_Price_Sold__c from Product2 where Name = 'Gandhiji Chasma'];
				if(proObj != null)
				{  
					if(proObj.Total_Price_Sold__c == null)
					{
						proObj.Total_Price_Sold__c = 0;
					}
				}
				else
				{
					System.debug('------------------->Product Not found');
				}
				//finding the containts of oli for search of gandhi ji chasma
				
				Decimal total = proObj.Total_Price_Sold__c;
				for(Opportunity oppTemp : oppList)
				{
					for(OpportunityLineItem oliTemp : oliList)
					{
						if(oppTemp.Id == oliTemp.OpportunityId && oliTemp.Product2Id == proObj.Id)
						{
							total +=  oliTemp.Subtotal;
						}
					}
				}
				System.debug('-------------> oli sub total '+total);
				proObj.Total_Price_Sold__c = total;
				
				try
				{
				update proObj;
				}
				catch(DMLException de)
				{
					System.debug(de.getCause());
					System.debug(de.getMessage());
				}
				
				
			}
			else   
			{
				System.debug('Unable to fetch opportunity Stage is not closed won ');
			}	
		}
	}
    
}