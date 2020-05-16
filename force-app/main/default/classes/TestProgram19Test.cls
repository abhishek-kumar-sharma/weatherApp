@isTest private class TestProgram19Test {
    @isTest private static void findUserLead()
    {
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, 
                          TimeZoneSidKey='America/Los_Angeles', UserName='stauser@testorg.com');
        
        System.runAs(u) {
            // The following code runs as user 'u' 
            System.debug('Current User: ' + UserInfo.getUserName());
            System.debug('Current Profile: ' + UserInfo.getProfileId());
            Lead l = new Lead();
            l.LastName = 'TEST LEAD';
            l.Company = 'ca';
            l.Status = 'Open - Not Contacted';
            //l.CreatedDate  = date.today();
            l.OwnerId = u.id;
            insert l;
            Lead l1 = new Lead();
            l1.LastName = 'TEST LEAD';
            l1.Company = 'ca';
            l1.Status = 'Open - Not Contacted';
            //l.CreatedDate  = date.today();
            l1.OwnerId = u.id;
            insert l1;
            //logic for created date 
            Datetime d1 = Datetime.now().addDays(-20);
            Test.setCreatedDate(l.Id, d1);
            Datetime d2 = Datetime.now().addDays(-10);
            Test.setCreatedDate(l1.Id, d2);
            
            Test.startTest();
            TestProgram19.findUserLead();
            Test.stopTest();
        }
        
    }
}