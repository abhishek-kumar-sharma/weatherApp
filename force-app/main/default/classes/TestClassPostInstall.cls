/**
* Created by ABHISHEK KUMAR SHARM on 06-02-2020.
*/
@isTest
public class TestClassPostInstall {
    static testMethod void testInstallScript() {
            
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id,
            LastName = 'last',
            Email = 'puser000@amamama.com',
            Username = 'puser000@amamama.com' + System.currentTimeMillis(),
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
        );
        
        PostInstallScriptClass postinstall = new PostInstallScriptClass();
        //Test.testInstall(postinstall);
        Test.testInstall(postinstall, null);
    }
   
}