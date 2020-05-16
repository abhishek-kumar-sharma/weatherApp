public class FetchAccountData {
    @AuraEnabled
    public static List<sobject> getAccountDetails()
    {
        try
        {	
            List<sobject> accList = new List<sobject>();
            try
            {
                accList = [SELECT NAME,TYPE,INDUSTRY,ANNUALREVENUE,PHONE FROM ACCOUNT WHERE TYPE != NULL LIMIT 100];
                return accList;
            }
            catch(DMLException dml)
            {
                System.debug('DML exception occurred --> '+dml.getMessage());
                return null;
            }
            
        }
        catch(Exception de)
        {
            System.debug('unable to fetch account ----> Cause ------->  '+de.getCause()+' Line Number -------> '+de.getLineNumber()+' Message ------->'+de.getMessage());
            return null;
        }
    }
    @AuraEnabled
    public static List<sobject> reGetSortData()
    {
        try
        {	
            List<Account> accList = new List<Account>();
            try
            {
                accList = [SELECT NAME,TYPE,INDUSTRY,ANNUALREVENUE,PHONE FROM ACCOUNT WHERE TYPE != NULL LIMIT 100];
                accList.sort();
                return accList;
            }
            catch(DMLException dml)
            {
                System.debug('DML exception occurred --> '+dml.getMessage());
                return null;
            }
            
        }
        catch(Exception de)
        {
            System.debug('unable to fetch account ----> Cause ------->  '+de.getCause()+' Line Number -------> '+de.getLineNumber()+' Message ------->'+de.getMessage());
            return null;
        }
    }
    
}