public class concateHandler {
	public static void concateLastName(List<Contact> conList)
	{
		set<ID> accountIdset = new set<ID>();
		List<Account> accList = new list<Account>();
		
		if(conList.size() > 0)
		{
			
			//add all the account Id to set for  fetching account
			for(Contact cont : conList){
				if(cont.AccountId != null){
					accountIdset.add(cont.AccountId);
				}
			}
			
			System.debug(accountIdset);
			
			//fetching account with accountId		
			accList = [select Id,Name from Account where Id IN:accountIdset];
			
			List<Account> accNewList = new List<Account>();
			
			for(Account accTemp : accList)
			{
					for(Contact conTemp : conList)
					{
						if(conTemp.AccountId != null)
						
						{
							if(accTemp.Id == conTemp.AccountId){
								accTemp.Name = accTemp.Name + conTemp.LastName;
							accNewList.add(accTemp);
							}
							
							
						}
					}
			}
		update accNewList;
			
		
		}
		
		
	}
    
}