/**
*********************************************************************************************************************
Created by : Abhishek Kumar Sharma
[CAT-RAJAT] : Cloud Analogy
Date : 07-October-2018
Description : This class is used as controller and data provider to Summer_2018_High_Lights component

*********************************************************************************************************************
*/
public class Summer_2018_High_Lights_Controller {
    /**
     * Method to fetch Account data
     */
    @AuraEnabled
    public static List<Account> getAllAccount_Apex() {
        try {
            List<Account> accountList = new List<Account>();
            accountList = [SELECT Name,Id,Phone,Rating,Website,AccountNumber,ECSV__Active_Status__c FROM Account LIMIT 200];
            if (accountList.size() > 0) {
                return accountList;
            } else {
                return null;
            }
        } catch (Exception exce) {
            system.debug('Exception occurred while fetching the Account :\n Message ::: ' + exce.getMessage() + ' Cause ::' + exce
                    .getCause() + ' Line Number :' + exce.getLineNumber());
            return null;
        }

    }

    /**
     * Method to upsert data
     */
    @AuraEnabled
    public static Boolean saveEditedAccounts(String modifiedAccountData) {
        try {
            system.debug('modifiedAccountData -->'+modifiedAccountData);
            List<Account> accountList = new List<Account>();
            accountList = (List<Account>)JSON.deserialize(modifiedAccountData,Account.class);
            system.debug('accountList --->'+accountList);


            if (accountList.size() > 0) {
                upsert accountList;
                return true;
            }
            return false;
        } catch (Exception exce) {
            system.debug('Exception occurred while deserializing the Account :\n Message ::: ' + exce.getMessage() + ' Cause ::' + exce
                    .getCause() + ' Line Number :' + exce.getLineNumber());
            return false;
        }
    }
}