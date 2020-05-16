public with sharing class GandhiJi {
	public static void chasmaGandhiJi()
	{
		/*Fecth opp having stage close won and hasopportuntiyline item true*/
		List<Opportunity> oppList = new List<Opportunity>();
		oppList = [select Name,StageName from Opportunity where StageName = 'Closed Won' and HasOpportunityLineItem = true];
		
		/*find the product id of gandhi ji chasma*/
		List<Product2> proList = new List<Product2>();
		proList = [select Id,Name from Product2 where Name = 'Gandhiji Chasma'];
		System.debug('-------------> '+proList);
	
		/*create opp id set*/
		Set<Id> oppIdSet = new Set<Id>();
		for(Opportunity oppTemp : oppList)
		{
			oppIdSet.add(oppTemp.Id);
		}
		
		if(oppList.size() > 0 )
		{
			/*find all the oli having product chasma via productid and opportutnityidset*/
			List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
			oliList = [select Name,OpportunityId,Product2Id,Quantity,TotalPrice from OpportunityLineItem where 
			OpportunityId IN: oppIdSet AND Product2Id IN: proList];      
			
			System.debug('--------'+oliList);
			/*for printing name of opportunity
			for(OpportunityLineItem oliTemp : oliList)
			{
				System.debug('---'+oliTemp.Name);
			}*/
			if(oliList.size() > 0 )
			{
				Decimal total = 0 ;
				for(OpportunityLineItem oliTemp : oliList)
				{
					total += oliTemp.TotalPrice;
				}	
				System.debug(total);
			}
			else
			{   
				System.debug('-----------NULL OLI LIST---------');
			}
		}
		
	}
    
}