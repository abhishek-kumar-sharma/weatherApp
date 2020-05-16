public with sharing class productSoldHandler {
	public static void productSoldIncr(List<Opportunity> oppList)
	{
		if(oppList.size() > 0)
		{
			/*Creating Id set of updated opportunity*/
			Set<Id> oppIdSet = new Set<Id>();
			for(Opportunity opTemp : oppList)
			{
				if(opTemp.StageName == 'Closed Won')
				{
					oppIdSet.add(opTemp.Id);
				}
			}
			System.debug('Id set of opportunity  -------> '+oppIdSet);
			
			/*Fetching opportunity Line item on opportunity id set for finding the product ID*/
			List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
			oliList = [select Product2Id,OpportunityId from OpportunityLineItem where OpportunityId IN: oppIdSet];
			
			System.debug('opportunity line item ---->'+oliList);
			
			/*Creating the OLI set for fetching the products*/
			Set<Id> oliIdSet = new Set<Id>();
			for(OpportunityLineItem oliTemp : oliList)
			{
				oliIdSet.add(oliTemp.Product2Id);
			}
			
			
			
			List<Product2> proList = new List<Product2>();
			List<Product2> updateProList = new List<Product2>();
			proList = [select No_of_Product_sold__c,Name from Product2 where Id IN:oliIdSet ];
			
			
			System.debug('New product list to update the solds--------> '+proList);
			
			for(Product2 newProObj : proList)
			{
				newProObj.No_of_Product_sold__c = newProObj.No_of_Product_sold__c+1;
				updateProList.add(newProObj);
			}
			update updateProList;
			
		}
		else
		{
			System.debug('--------------------------Null List of Opportunity recieved---------------------');
		}
	}
    
}