@isTest private class Test2Test {
    @istest private static void Test2()
    {
        
        Lead l = new Lead();
        l.LastName ='hdgfj';
        l.Records__c = 'Tenant;Buyer';
        l.Company = 'sdjsdk';
        insert l;
        
        Test.startTest();
        Test2.fetchSellerAndTenant();
        Test.stopTest();
    }

}