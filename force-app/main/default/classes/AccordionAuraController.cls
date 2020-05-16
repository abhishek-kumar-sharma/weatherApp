public class AccordionAuraController {
    @AuraEnabled
    public static List<Contact> getContacts(){
        List<Contact> contactList = new List<Contact>();
        for(Contact oCon : [SELECT Id, Name, Email, Phone, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry From Contact]){
           contactList.add(oCon); 
        }
        return contactList;
    }
}