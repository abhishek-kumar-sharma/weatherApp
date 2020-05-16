public class challenge1 {
	public static void findRating()
	{
		List<Actors__c> actorList = new List<Actors__c>();
		actorList=[select Id,Rating__c,Account__c,Name from Actors__c where Rating__c >= 10 AND (Name like 'A%' OR Name like 'D%')];
		System.debug('data from actor list ---->  '+actorList);
		
		List<Account> accList=[select Total_Rating__c from Account ];
		if(accList.size() > 0)
		{
		for(Account accTemp : accList)
		{
			for(Actors__c actorTemp : actorList)
			{
				if(actorTemp.Account__c == accTemp.Id)
				{
					if(accTemp.Total_Rating__c == null)
					{
						accTemp.Total_Rating__c=0;
						accTemp.Total_Rating__c += actorTemp.Rating__c;
						
					}
					else
					{
						accTemp.Total_Rating__c +=  actorTemp.Rating__c;
					}
				}
			}
		}
		}
		else
		{
			System.debug('Account null');
		}
		update accList;
		System.debug(accList);
		
		
		
				
	}
    
}