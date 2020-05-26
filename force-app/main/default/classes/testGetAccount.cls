public with sharing class testGetAccount {
    
    @AuraEnabled
    public static List<Account> getAccountList(){
        return [Select id,name from Account limit 10];
    }

    @AuraEnabled
    public static List<Opportunity> getOpportunityFromAccountId(String accountId){
        if (String.isNotBlank(accountId)) {
            accountId = accountId.removeEnd('-1');
            return [select id,AccountId,Name from Opportunity where AccountId =: accountId];
        }
        return null;
    }
}
