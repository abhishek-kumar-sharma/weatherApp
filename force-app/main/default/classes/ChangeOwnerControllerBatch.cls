/**
controller class for TaskFirst Component

*/

global with sharing class ChangeOwnerControllerBatch {
    
    
    /* Method to handle component data */
    @AuraEnabled
    public static void changeOwnerId_Apex(String recordId,String sObjectName)
    {
        if((recordId != null || recordId != '' || recordId != 'undefined') &&( sObjectName != null || sObjectName != ''|| sObjectName != 'undefined'))
        {
            Database.executeBatch(new ChangeOwnerBatch(recordId,sObjectName));
        }
        else
        {
            System.debug('Unable to call change owner batch');
        }
        
        
        
    }
    
}