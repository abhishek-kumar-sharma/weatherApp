public class AccountProcessor {
    @future
    
    public static void countContacts(List<id> scope) {
         
        Account[] updates = new Account[] {};
            for (AggregateResult ar : [
                select AccountId a, count(Id) c
                from Contact
                where AccountId in :scope
                group by AccountId
            ]) {
                updates.add(new Account(
                    Id = (Id) ar.get('a'),
                    Number_of_Contacts__c = (Decimal) ar.get('c')
                ));
            }
        update updates;
    }}