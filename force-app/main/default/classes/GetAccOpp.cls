public with sharing class GetAccOpp {
	public static void coutOli()
	{

		List<Account> acclist = new List<Account>();
		acclist = [SELECT Id FROM Account];
		List<Account> showaa = new List<Account>();
		Set<Id> AIds = new Set<Id>();
		List<Opportunity> opp = new List<Opportunity>();
		opp = [SELECT Id,AccountId FROM Opportunity WHERE AccountId IN : acclist AND HasOpportunityLineItem = TRUE];
		System.debug(opp);
		List<OpportunityLineItem> oli = new List<OpportunityLineItem>();
		oli = [ SELECT Id,OpportunityId FROM OpportunityLineItem WHERE OpportunityId IN : opp];
		
		Map<Id,Integer> listmapIds = new Map<Id, Integer>();
		
		for(OpportunityLineItem op : oli){
		 if(!listmapIds.containsKey(op.OpportunityId)){
		 listmapIds.put(op.OpportunityId,1);
		 }else {
		 Integer count=listmapIds.get(op.OpportunityId);
		 count = count +1;
		 listmapIds.put(op.OpportunityId,count);
		 
		 }
		}
		
		
		for(Opportunity oo : opp){
		 if(listmapIds.containsKey(oo.Id)){
		 Integer CC = listmapIds.get(oo.Id);
		 if(CC>2){
		 AIds.add(oo.AccountId);
		 }
		 }
		}
		showaa= [SELECT Name FROM Account WHERE Id IN : AIds];   
		System.debug(showaa);
	}
    
}