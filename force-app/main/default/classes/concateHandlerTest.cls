@istest private class concateHandlerTest {
	@isTest static void concateHandler()
	{
		Account accountObject = new Account();
		accountObject.Name = 'Test';
		insert accountObject;
		
		Contact contactObject = new Contact();
		contactObject.LastName = 'TeesssT';
		contactObject.AccountId = accountObject.Id;
		insert contactObject;
	}
    
}