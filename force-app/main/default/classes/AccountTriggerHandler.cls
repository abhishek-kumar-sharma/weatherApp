public class AccountTriggerHandler {
    public static void createContacts(List<Account> accountList){
        List<Contact> contactListToInsert = new List<Contact>();
        for(Account accInstance : accountList){
            for(Integer i=0;i<accInstance.NumberOfEmployees;i++){
                Contact contactInstance = new Contact();
                contactInstance.LastName='Con'+i;
                contactInstance.AccountId = accInstance.Id;
                contactListToInsert.add(contactInstance);
            }
        }
        insert contactListToInsert;
    }
}