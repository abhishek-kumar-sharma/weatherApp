@isTest private class ClosedOppTrigger {
	@isTest static void testMyMethod()
	{
		Opportunity oppobj = new Opportunity();
		oppobj.Name = 'Test';
		oppobj.StageName = 'Closed Won';
		oppobj.CloseDate = date.today();
		insert oppobj;
	}
    
}