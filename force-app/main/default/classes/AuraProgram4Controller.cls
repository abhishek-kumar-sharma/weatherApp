global class AuraProgram4Controller {
    public static Integer no_of_field;
    
    @AuraEnabled
    public static List<String> fetchSobject()
    {
        List<Schema.SObjectType> gd = Schema.getGlobalDescribe().Values();
        List<String> newReturnList = new List<String>();
        for(Schema.SObjectType f : gd)
        {
            //options.add(new SelectOption(f.getDescribe().getLabel(),f.getDescribe().getLabel()));
            system.debug('Object Name : ' + f.getDescribe().getName());
            newReturnList.add(f.getDescribe().getName());
        }
        
        newReturnList.sort();
        System.debug('---> set values --->'+newReturnList); 
        return  newReturnList;
        
    }
    
    @AuraEnabled
    public static List<String> getAllFieldsName (String objname)
    {
        
        //variable value from pick list one select
        String str = objname;
        Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(str).getDescribe().fields.getMap();
        List<String> strList = new List<String>();
        
        for(String temp : objectFields.keySet())
        {
            String strTemp = String.valueOf(objectFields.get(temp));
            System.debug('------> strTmp ----> '+strTemp);
            strList.add(strTemp);
        }
        
        System.debug('Fields return ----> '+strList);
        return strList;
        
    }    
    @AuraEnabled
    public static String getDataType_Apex (String objname,String fieldName)
    {
        
        System.debug('Object name in getDataType () ----> '+objname);
        System.debug('Field name in getDataType () -----> '+fieldName);
        if(fieldName == 'null' || fieldName == null ||fieldName == '' )
        {
            System.debug('-----------------> null ');
            return null;
        }
        else
        {
            String sObj = String.valueOf(objname);
            String sobj_Field = String.valueOf(fieldName);
            Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(sObj).getDescribe().fields.getMap();
            Schema.SObjectField field = objectFields.get(sobj_Field);
            Schema.DisplayType DataType = field.getDescribe().getType();
            
            if(DataType != null)
            {  
                String str = String.valueOf(DataType);
                System.debug('returned value in getDataType() ---> '+str);
                return str;
            }
            else
            {
                return null;
            }
        }
        
    }  
    
    @AuraEnabled
    public static List<sObject> getDataByQuery_Apex(String rec_Query)
    {
        try
        {
            System.debug('Query ----------> '+rec_Query);
            List<sObject> return_Query_List = new List<sObject>();
            if(rec_Query == null || rec_Query == '' || rec_Query == 'undefined' )
            {
                return null;
            }
            else
            {
                return_Query_List = Database.query(rec_Query);
                System.debug('--------> query problem area----------> '+return_Query_List);
                return return_Query_List;
            }
        }
        catch(Exception de)
        {
            System.debug('Exception Occurred due to '+de.getCause()+' Line number '+de.getLineNumber()+' Message '+de.getMessage());
            return null;
        }
    }
    
    @AuraEnabled
    public static List<sObject> getObjectByFieldName_Apex(String objName,String fieldName)
    {
        if(objName == 'null'||objName == ''||objName == 'undefined' || fieldName ==''||fieldName == 'null'||fieldName=='undefined')
        {
            return null;
        }
        else
        {
            map<String,Schema.SObjectType> GlobalMap = Schema.getGlobalDescribe();
            Schema.DescribeSObjectResult objectName = GlobalMap.get(objName).getDescribe();
            Schema.DescribeFieldResult objectFieldref = objectName.Fields.getMap().get(fieldName).getDescribe();
            /* object name and field name */
            System.debug('object name ---> '+objectFieldref.getLabel()+'----------> reference -->'+objectFieldref.getreferenceTo());
            String refObjName = String.valueOf(objectFieldref.getreferenceTo());
            /* Removing () from start and end*/
            String tempString = refObjName.removeEnd(')');
            tempString = refObjName.removeStart('(');
            refObjName = tempString;



            /*getting data */
            List<SObject> dataList = new List<SObject>();
            String query = 'Select id,Name from'+refObjName;
            dataList = Database.query(query);
            System.debug('------------> data list in getObjectByFieldName_Apex () -----> '+dataList);
            
            return dataList;
            
            
        }
    }
    
    
}