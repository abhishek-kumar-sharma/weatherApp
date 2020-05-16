public class TaskAlightning {
    @AuraEnabled
    public static Contact saveContact(Contact con)
    {
        System.debug('-------------------> contact  recieved-------------------------->');
        
        contact conObject = new Contact();
        conObject.FirstName = con.FirstName;
        conObject.LastName = con.LastName;
        conObject.Email = con.Email;
        //conObject.Password__c = con.Password__c;
        conObject.MailingStreet = con.MailingStreet;
        conObject.MailingCity = con.MailingCity;
        conObject.MailingPostalCode = con.MailingPostalCode;
        conObject.MailingState = con.MailingState;
        try
        {
            
            insert conObject;
            
        }
        catch(Exception ex)
        {
            System.debug(ex.getMessage());
        }
        return conObject;
        
        
    }
    
}