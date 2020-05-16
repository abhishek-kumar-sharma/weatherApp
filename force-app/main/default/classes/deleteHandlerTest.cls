@istest private class deleteHandlerTest {
	@isTest static void removeLastNameTest()
	{
		Account accObj = new Account();
		accObj.Name = 'Test LastName';
		insert accObj;
		
		Contact conObj = new Contact();
		conObj.LastName = 'LastName';
		conObj.AccountId = accObj.Id;
		insert conObj;
	}
    
}