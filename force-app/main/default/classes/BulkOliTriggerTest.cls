@isTest private class BulkOliTriggerTest {
     @isTest private static void oliTest()
     {
         Id pricebookId1 = Test.getStandardPricebookId();
        Product2 prod = new Product2(
            Name = 'Gandhiji Chasma',
            Total_Product_available__c = 10,
            Total_Price_Sold__c = 10,
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
        //old oli list 
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
         
         //new oli list
         ////old oli list 
        Opportunity opp1 = new Opportunity();
        opp1.Name='Test';
        opp1.CloseDate=Date.today();
        opp1.StageName='Closed Won';
        insert opp1;
        
        OpportunityLineItem oli1 = new OpportunityLineItem();
        oli1.Product2Id = prod.Id;
        oli1.OpportunityId = opp1.Id;
        oli1.PricebookEntryId = pbEntry.Id;
        oli1.Quantity = 2;
        oli1.TotalPrice = 10;
        insert oli1;
         
         
     }

}