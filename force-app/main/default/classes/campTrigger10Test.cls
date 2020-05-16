@isTest private class campTrigger10Test {
	@isTest  static void campHandlerTest()
	{
		Campaign campaignObject = new Campaign();
		campaignObject.Name = 'campaign test';
		campaignObject.Status = 'Completed';
		insert campaignObject;
		
		Opportunity opportunityObject = new Opportunity();
		opportunityObject.Name = 'Test opportunity';
		opportunityObject.StageName = 'Closed Won';
		opportunityObject.CloseDate = date.today();
		opportunityObject.CampaignId = campaignObject.Id;
		insert opportunityObject;
		
		
		System.debug('----------------------------->Test class print '+opportunityObject);
		
		
	}
    
}