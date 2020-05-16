public class TaskBComponentHandler {
    @AuraEnabled
    public static Contact fetchContact(Contact con)
    {
        /*if(con.Email== '' || con.Email== Null || con.Password__c == ''||con.Password__c ==NULL){
            return null;
        }*/
       // System.debug('rec -----------------> '+con.Password__c);
        List<Contact> conObject = [select FirstName,LastName from Contact where Email =:con.Email ];
        if(conObject.size()>0)
        {
            return conObject[0];
        }
        else
        {
            return null;
        }
    }
       
    
}