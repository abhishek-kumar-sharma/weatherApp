public class deleteHandler {
	public static void removeLastName(List<Contact> conList)
	{
		System.debug('recieved List ---------------->   ' +conList +'   done');
		System.debug(conList);
		if(conList.size() > 0) //Null check for contact list
		{
			
			Set<Id> delContactIdSet = new Set<Id>();
			for(Contact conTempList : conList )
			{
				if(conTempList.AccountId != null)
				{
					delContactIdSet.add(conTempList.AccountId);
				}
			}
			
			System.debug('deleteing contact id ------- > '+delContactIdset);
			
			//fetch account associated with deleted contact
			List<Account> newAccountList = new List<Account>();
			newAccountList= [select Id,Name from Account where Id IN: delcontactIdset];
			
			
			List<Account> newAccList = new List<Account>();
			//removing contact last name form account name
			if(newAccountList.size() > 0)
			{
				for(Account accTemp : newAccountList)
				{
					for(Contact conTemp : conList)
					{
						if(conTemp.AccountId == accTemp.Id)
						{
							/*Account accObj = new Account();
							String str = conTemp.LastName;
							String str1 = accObj.Name;
							accObj.Name = accObj.Name.Remove(conTemp.LastName);
							newAccList.add(accObj);*/
							if(String.valueof(accTemp.Name).contains(String.valueof(conTemp.LastName))){
								accTemp.Name = accTemp.Name.Remove(conTemp.LastName);
								newAccList.add(accTemp);
						}
							}
							 //do this with map to remove the nested loop
					}
				}
				update newAccList;
				System.debug('final');
				System.debug(newAccList);
			}			
			
			
		}
		System.debug('Null list recieved');
	}
}