public class newCh {
    public static void calculateTotal()
    {
    	List<Actors__c> actorList = new List<Actors__c>();
    	actorList=[select Name,Account__c,Rating__c from Actors__c where Rating__c >= 10 AND (Name like 'a%' OR Name like 'd%')]; 
    	Set<Id> accIdSet = new Set<Id>();
    	map<id,List<Actors__c>> accMap = new map<id,List<Actors__c>>();
    	
    	
    	if(actorList.size() > 0)
    	{
    		for(Actors__c actorTemp : actorList)
    		{
    		accIdSet.add(actorTemp.Account__c);
    		if(accMap.get(actorTemp.Account__c) == null) //it is short query for 'select Account__c from accMap' it iterate the whole map automatically for check id
    		{
    			accMap.put(actorTemp.Account__c,new List<Actors__c>());
    			
    		}
    		else
    		{
    			accMap.get(actorTemp.Account__c).add(actorTemp);//first we get the actor account id from map and then we add the actor object to List<Actors__C>
    		}
    	}
    	}
    	
    	//creating id set 
    	
    	
    	
    	List<Account> updateAccList = new List<Account>();
    	List<Account> accList = new List<Account>();
    	accList=[Select Name,Total_Rating__c from Account where Id IN: accIdSet ];
    	if(accList.size() > 0)
    	{
    		for(Account acc : accList)
    	{
    		List<Actors__c> newActorList = new List<Actors__c>();
    		newActorList = accMap.get(acc.Id);
    		Decimal totalRating = 0 ;
    		for(Actors__c actTemp : newActorList)
    		{
    			totalRating += actTemp.Rating__c;
    		}
    		acc.Total_Rating__c = totalRating;
    		updateAccList.add(acc);
    		System.debug(updateAccList);
    	}
    	}
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	update updateAccList;
    	
    	System.debug('total rating '+updateAccList);
    	
    	
    	
    	
    	
    	
    }
}