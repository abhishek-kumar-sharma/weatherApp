/*Create Batch class to create 5 new Opportunities daily*/
global without sharing class BatchProgram4 implements Database.Batchable<sObject>  {
      global Database.QueryLocator start(Database.BatchableContext bc)
      {
          String query = 'select Name from Opportunity where CreatedDate = LAST_N_DAYS :2'  ;
          return Database.getQueryLocator(query);
      }
    
    global static void execute(Database.BatchableContext bc , List<Opportunity> oppList)
    {
        System.debug('-------------------------------------- Btach'+oppList);
        for(Integer i=0;i<6;i++)
        {
            Opportunity oppObject = new Opportunity();
            oppObject.Name = 'Daily opp '+date.today();
            oppObject.StageName = 'Prospecting';
            oppObject.CloseDate = date.today()+10;
            oppList.add(oppObject);
        }
        try
        {
            upsert oppList;
            System.debug('Upsert List from Batch ==============> '+oppList);
        }
        catch(DMLException de)
        {
            System.debug(de.getMessage());
        }
    }
    global void finish(Database.BatchableContext bc)
    {
        system.debug('----------------------------------FINISH----------------------------------');
    }
    
   

}