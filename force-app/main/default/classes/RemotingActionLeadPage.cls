/**
 * @Created by ABHISHEK on 25-06-2019.
 */

public with sharing class RemotingActionLeadPage {
    @RemoteAction
    public static List<Lead> getLeadRecords_Apex(){
        try{
            List<Lead> leadList = new List<Lead>();
            String queryString = 'select Id,Name,Next_Step__c,Next_Step_Due_Date__c,Company,Status,IsConverted from lead' +
                    ' where Status NOT IN (\'Closed - Converted to Opportunity\',\'Closed - Nurture, No Need At This Time\',' +
                    '\'Closed - No Potential\',\'Closed - Forbidden\',\'Closed - Bad Customer\',\'Closed - Disqualified\') ' +
                    'AND IsConverted != true ORDER bY Next_Step_Due_Date__c desc';
            String testQuery = 'select Id,Name from lead';
            System.debug('query string ');
            System.debug(testQuery);
            leadList = Database.query(testQuery);
            System.debug('leadListleadListleadList');
            System.debug(leadList);
            if (!leadList.isEmpty()) {
                return leadList;
            }else{
                return null;
            }

        }
        catch(Exception exce){
            System.debug('Exception occurred while getting the records from leads. \n Message ::'+exce.getMessage()+
                    '\n Cause ::'+exce.getCause()+' \n Line Number :'+exce.getLineNumber());
            return null;
        }
    }

}