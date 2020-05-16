@isTest
public class updateAccessTokencontrollerTest {
    @isTest
    public static void testControllerMethod() {
        try {
            PageReference pageRef = Page.updateAccessToken;
            Test.setCurrentPage(pageRef);
            updateAccessTokencontroller clsObject = new updateAccessTokencontroller();
			clsObject.accessToken.Name = 'Test Access Token';
            clsObject.accessToken.ECSV__Access_Token__c = '0123456789';        
          	System.debug(clsObject.saveRecord());
            //PageReference objPageRef = clsObject.saveRecord();
        } 
        catch(Exception ex) {
            System.debug('Exception is -->'+ex.getMessage()+' in line number -->'+ex.getLineNumber());
        }        
    }   
}