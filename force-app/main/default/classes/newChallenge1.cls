public class newChallenge1 {
	public static void totalRating()
	{
		List<Actors__C> actorList = new List<Actors__C>();
		actorList=[select Id,Name,Rating__c,Account__c from Actors__C where Rating__c >= 10 AND (Name like 'A%' OR Name like 'D%')];
			
		//printing all the data from Actors List 
		System.debug('Data from Actor__c List ----> '+actorList);
		
		Map<Id,List<Integer>> actorMap = new Map<Id,List<Integer>>();
		
		set<id> keySet = new set<id>();
		for(Actors__c ac : actorList)
		{
			keySet.add(ac.Account__c);
			if(ac.Rating__c!=null){
				if(actorMap.get(ac.Account__c)==Null){
					actorMap.put(ac.Account__c,new List<Integer>());
				}
				actorMap.get(ac.Account__c).add(Integer.valueof(ac.Rating__c));
			}
			
			
		}
		
		System.debug(keySet);
		
		List<Account> accList = new List<Account>();
		List<Account> newAccList = new List<Account>();
		
		accList = [select Name,Total_Rating__c from Account where Id IN: keySet];
		System.debug(accList);
		Integer totalRating = 0;
		
		for(Account acc :accList ){
			
			if(actorMap.containsKey(acc.id)){
				List<Integer> ratinglist = new List<Integer>();
				ratinglist = actorMap.get(acc.Id);
				System.debug(ratingList);
				if(ratingList.size() > 0)
				{
					for(Integer i : ratingList)
					{
						Account accObj = new Account();
						totalRating=totalRating + i;
						accObj.Total_Rating__c = totalRating;
						newAccList.add(accObj);
					}
				}
				
			}
		
		}
		System.debug('total Rating -----> '+totalRating);
		
		 
	}
}