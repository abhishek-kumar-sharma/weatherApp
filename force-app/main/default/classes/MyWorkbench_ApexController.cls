/**
 * Created by abhishek on 8/3/18.
 * class to handle apex related task of MyWorkbenchCmp Component
 */

public with sharing class MyWorkbench_ApexController
{

    /* method to load all object*/
    @AuraEnabled
    public static List<String> loadObject_Apex()
    {

        List<Schema.SObjectType> globalDSObjectTypes = Schema.getGlobalDescribe().values();

        //list to return object name
        List<String> objectNameList = new List<String>();
        //adding object name to list
        for(Schema.SObjectType tempObjectType : globalDSObjectTypes)
        {
            String objectNameString = tempObjectType.getDescribe().getName();
            System.debug('Object Name ---> ' +objectNameString);
            objectNameList.add(objectNameString);
        }
        if(objectNameList.size() > 0 )
        {
            System.debug('Returned list --> '+objectNameList);
            return objectNameList;
        }
        else
        {
            System.debug('Unable to fetch Objects ... ');
            return  null;
        }

    }

    /*Method to load all fields*/
    @AuraEnabled
    public static List<String> loadAllFields_Apex(String objectName)
    {
        if (objectName != null || objectName != 'undefined' || objectName != '')
        {
            Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
            List<String> fieldLiStrings = new List<String>();

            for(String temp : objectFields.keySet())
            {
                String strTemp = String.valueOf(objectFields.get(temp));
                System.debug('load field method of apex '+strTemp);
                fieldLiStrings.add(strTemp);
            }

            System.debug('Fields return ----> '+fieldLiStrings);
            return fieldLiStrings;

        }
        else
        {
            return null;
        }
    }

    /*Method to load data by received query */
    @AuraEnabled
    public static List<SObject> loadData_Apex(String rec_QueryString)
    {
        if(rec_QueryString == 'null'|| rec_QueryString == null || rec_QueryString == '' || rec_QueryString == 'undefined')
        {
            return null;
        }
        else
        {
            List<SObject> resultList = new List<SObject>();
            resultList = Database.query(rec_QueryString);
            if(resultList.size() > 0 )
            {
                return resultList;
            }
            else
            {
                return null;
            }
        }
    }

    /* */
}