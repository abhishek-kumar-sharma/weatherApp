public with sharing class ContactAddressCopyHandler {
	public static void addressCopy(List<Contact> conList)
	{
		if(conList.size() > 0 )
		{
			/*Getting the user Address*/
			User user = new User();
			user = [select city,country,state,Username from User where Username =: userInfo.getUserName() ];
			System.debug(user);
			
			Set<Id> accIdSet = new Set<Id>();
			
			for(Contact conTemp : conList )  
			{
				if(conTemp.MailingCity == null)
				{
					conTemp.MailingCity = user.city;
				}
				if(conTemp.MailingState == null)
				{
					conTemp.MailingState = user.state;
				}
				if(conTemp.MailingCountry == null)
				{
					conTemp.MailingCountry = user.Country;
				}
				
				if(conTemp.AccountId != null)
				{
					accIdSet.add(conTemp.AccountId);
				}
			}
			List<Account> accList = new List<Account>();
			accList = [select BillingCity,BillingCountry,BillingState from Account where Id IN: accIdSet];
			for(Account accTemp : accList)
			{
				if(accTemp.BillingCity == null)
				{
					accTemp.BillingCity = user.city;
				}
				if(accTemp.BillingCountry == null)
				{
					accTemp.BillingCountry = user.country;
				}
				if(accTemp.BillingState == null)
				{
					accTemp.BillingState = user.state;
				}
				
			}
			update accList;
			
		}
	}
    
}