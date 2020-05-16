/*
calling class ChangeOwnerControllerBatch
 */

global with sharing class ChangeOwnerBatch implements Database.Batchable<sObject> {

    private String recordId;
    private String sObjectName;

    public ChangeOwnerBatch(String recordIdString , String sObjectNameString)
    {
        recordId = recordIdString;
        sObjectName = sObjectNameString;
        System.debug('In batch ---> record ID' +recordId+'   sobject name ---> '+sObjectName);

    }


    /* Batch code start */
    global Database.QueryLocator start(Database.BatchableContext batchableContext)
    {
        /* Fetching the data */
        String query = 'SELECT Id,OwnerId FROM '+sObjectName+' WHERE Id = '+'\''+recordId+'\'';
        System.debug('In Batch Query data --> ' +query);
        return Database.getQueryLocator(query);

    }
    global void execute(Database.BatchableContext batchableContext ,List<SObject> sObjectList)
    {
        if (sObjectList.size() > 0)
        {

            User usr = new User();
            usr = [SELECT Id FROM User where IsActive = false limit 1];
            /*Fetching user id and assigning owner id*/
            System.debug('IN  Batch guest user id ---> ' +usr.Id);

            for(SObject sObjectTemp : sObjectList)
            {
                sObjectTemp.put('OwnerId',usr.Id);

            }
            try
            {
                System.debug('Upsert List ' +sObjectList);
                update sObjectList;
            }
            catch (Exception de)
            {
                System.debug('Exception occurred while upserting . Cause --> '+de.getCause()+' Message --> '+de.getMessage());
            }

        }
        else
        {
            System.debug('Error in execute method');
        }

    }
    global void finish(Database.BatchableContext batchableContext)
    {
        System.debug('--------> Changed ');
    }



}