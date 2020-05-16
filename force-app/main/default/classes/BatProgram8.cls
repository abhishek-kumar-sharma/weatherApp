/*Create Batch to update the Account "Count" field(Create this field) with all the contacts related to that Account*/
global class BatProgram8 implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext bc)
    {
        String query = 'Select LastName,FirstName,AccountId from Contact where AccountId != null';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext bc,List<Contact> conList)
    {
        if(conList.size() > 0 )
        {
            map<Id,Integer> accIdVsNoConMap = new map<Id,Integer>();
            for(Contact conTemp : conList)
            {
                if(!accIdVsNoConMap.containsKey(conTemp.AccountId))
                {
                    accIdVsNoConMap.put(conTemp.AccountId,1);
                }
                else
                {
                    Integer i = accIdVsNoConMap.get(conTemp.AccountId);
                    i++;
                    accIdVsNoConMap.put(conTemp.AccountId,i);
                }
            }
            
            List<Account> accList = new List<Account>();
            accList = [Select Name,count__c from Account where Id IN: accIdVsNoConMap.keySet()];
            if(accList.size() > 0 )
            {
                for(Account accTemp : accList)
                {
                    if(accIdVsNoConMap.containsKey(accTemp.Id))
                    {
                        accTemp.count__c = accIdVsNoConMap.get(accTemp.Id);
                    }
                }
                upsert accList;
                System.debug('Updated list Account ------> '+accList);
            }
        }
        else
        {
            System.debug('NULL CONTACT LIST RECIEVED');
        }
    }
    global void finish(Database.BatchableContext bc)
    {
        System.debug('Finish');
    }
}

/*
Execute ana.....
BatProgram8 bcPro8 = new BatProgram8();
System.debug('---------> '+Database.executeBatch(bcPro8));
*/