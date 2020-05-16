/*Trigger to throw error when a Contact is getting inserted in Salesforce having Country
 same as User country and Company country
 trigger Name --ContactMailingAddressTrigger
*/
public with sharing class ContactMailingAddressChecker {
	public static void checkMailingAddress(List<Contact> conList)
	{
		if(conList.size() > 0 )
		{
			User userObj = new User();
			userObj = [select Country from User where email =: UserInfo.getUserEmail()];
			for(Contact conTemp : conList)
			{
				if(conTemp.MailingCountry == userObj.Country && conTemp.MailingCountry != null && conTemp.SAME_COUNTRY_AS_USER_COMPANY__c == true)
				{
					conTemp.addError('Unable to insert contact');
				}
			}
		}
	}
    
}