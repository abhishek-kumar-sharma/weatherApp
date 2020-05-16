@isTest private class CampaignTest {
    @isTest private static void campHandlerTest()
    {
        Campaign camp=new Campaign();
        camp.Name='test camp';
        camp.Status='Completed';
        insert camp;
         Id pricebookId1 = Test.getStandardPricebookId();
        Product2 prod = new Product2(
            Name = 'Gandhiji Chasma',
            ProductCode = 'Pro-X',
            isActive = true
        );
        insert prod;
        
        PricebookEntry pbEntry = new PricebookEntry(
            Pricebook2Id = pricebookId1,
            Product2Id = prod.Id,
            UnitPrice = 100.00,
            IsActive = true
        );
        insert pbEntry;
        
         Opportunity opp = new Opportunity();
        opp.Name='Test';  
        opp.CloseDate=Date.today();
        opp.StageName='Closed Won';
        opp.CampaignId=camp.Id;
        insert opp; 
        
        OpportunityLineItem oli = new OpportunityLineItem();
        oli.Product2Id = prod.Id;
        oli.OpportunityId = opp.Id;
        oli.PricebookEntryId = pbEntry.Id;
        oli.Quantity = 2;
        oli.TotalPrice = 10;
        insert oli;
        camp.Status='Completed';
        update camp;
        
    }
    
}