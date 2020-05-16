@isTest private class GandhiJiTest {
    @isTest static void chasmaGandhiJiTest()
    {
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
        insert opp;
        
        OpportunityLineItem oli = new OpportunityLineItem();
        oli.Product2Id = prod.Id;
        oli.OpportunityId = opp.Id;
        oli.PricebookEntryId = pbEntry.Id;
        oli.Quantity = 2;
        oli.TotalPrice = 10;
        insert oli;
        
        Test.startTest();
        GandhiJi.chasmaGandhiJi();
        Test.stopTest();
    }
    
}