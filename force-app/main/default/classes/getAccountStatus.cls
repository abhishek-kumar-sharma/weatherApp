public class getAccountStatus {
    @AuraEnabled 
    public static List<wrapperAccount> accAllData()
    {
        List<wrapperAccount> waList = new List<wrapperAccount>();
        
        List<Account> accList = new List<Account>();
        accList = [select id,Name,Status__c,CreatedDate from Account where Status__c != null];
        for(Account acc : accList)
        {
            wrapperAccount waObject = new wrapperAccount();
            waObject.accObject = acc;
            waObject.checkBox = false;
            waList.add(waObject);
        }
        System.debug('wrapper data ---> '+waList);
        if(waList.size() > 0 )
        {
            System.debug('Returned List ---->'+waList);
            return waList;
        }
        else
        {
            return null;
        }
    }
    
    public class wrapperAccount
    {
        @AuraEnabled
        public Account accObject;
        @AuraEnabled
        public boolean checkBox;
    }
    
}