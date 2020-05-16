@isTest private class TestPro19Test {
    @isTest private static void getTotalQuantity()
    {
        Account acc = new Account();
        acc.Name = 'account Name';
        acc.Working_in__c = 'Asia';
        insert acc;
        
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
        opp.AccountId = acc.Id;
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
         OpportunityLineItem olin = new OpportunityLineItem();
        olin.Product2Id = prod.Id;
        olin.OpportunityId = opp.Id;
        olin.PricebookEntryId = pbEntry.Id;
        olin.Quantity = 2;
        olin.TotalPrice = 10;
        insert olin;
        
        
       
        Test.startTest();
        TestPro19.getTotalQuantity();
        Test.stopTest();
    }

}