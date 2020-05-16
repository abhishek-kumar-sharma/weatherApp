public with sharing class TestProgram12 {
	public static void sameCountryAddress()
	{
		List<Contact> conList = new List<Contact>();
		User userObj = new User();
		userObj = [select Street,Country,State from User where email =: UserInfo.getUserEmail()];
		
		conList = [select LastName,MailingStreet,MailingCountry,MailingState from Contact where	MailingStreet =: userObj.Street AND MailingCountry =: userObj.Country AND MailingState =: userObj.State];
		  System.debug('Contact List ---> '+conList); 
	}
    
}