@isTest private class BulkProductTest {
	@isTest private static void initProductPriceTest()
	{
		Pricebook2 pb = new Pricebook2();
        pb.Id=Test.getStandardPricebookId();
        update pb;
        System.debug('----------------------->Test class standard pb '+pb);
        
        Product2 proObject = new Product2();
        proObject.Name = 'test pro';
        insert proObject;
        System.debug('--------------------------> test class product'+proObject);
           
        Pricebookentry  pbe = new PricebookEntry();
        pbe.Pricebook2Id= pb.Id;
        pbe.Product2Id = proObject.Id;
        pbe.UnitPrice= 12;  
        pbe.IsActive=true;
        insert pbe;
        System.debug('-----------------------------------> '+pbe);
        
        
	}
    
}