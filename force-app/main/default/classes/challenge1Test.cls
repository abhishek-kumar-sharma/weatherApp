@isTest private class challenge1Test {
    @isTest private static void findRatingTest()
    {
    	Account accObj = new Account();
    	accObj.Name ='hello';
    	accObj.Total_Rating__c =50;
        insert accObj;
        
    	Actors__c actorObj = new Actors__c();
    	actorObj.Rating__c =12;
    	actorObj.Account__c = accObj.Id;
    	actorObj.Name = 'abmmasete';
    	insert actorObj;

    	Test.startTest();
    	challenge1.findRating();
    	Test.stopTest();
    }
    
    
    @isTest private static void findRatingTest_01()
    {
        Account accountObject = new Account();
        accountObject.Name = 'test';
        insert accountObject;
        
        Actors__c actorObject = new Actors__c();
    	actorObject.Rating__c =12;
    	actorObject.Account__c = accountObject.Id;
    	actorObject.Name = 'abmma';
    	insert actorObject;
        
        Test.startTest();
    	challenge1.findRating();
    	Test.stopTest();
    }
}