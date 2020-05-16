/*Batch class program to delete accounts created in 10 days before.*/

global without sharing class BatchProgram1 implements Database.Batchable<sObject> {
	 global Database.QueryLocator start(Database.BatchableContext bc)
	 {
	 	String query = 'SELECT Id,Name FROM Account WHERE CreatedDate = LAST_N_DAYS:5';
	 	return Database.getQueryLocator(query);
	 }
	 global void execute(Database.BatchableContext bc, List<Account> accList)
	 {
	 	if(accList.size() > 0 )
	 	{
	 		for(Account accTemp : accList)
	 		{
	 			accTemp.Name = accTemp.Name + 'Batch Test';
	 		}
	 		
	 		try
	 		{
	 			update accList;
	 			System.debug(accList);
	 			Database.delete(accList,false);
	 			System.debug('-----------------------------------------');
	 			System.debug(accList);
	 		}
	 		catch(Exception e)
	 		{
	 			System.debug(e.getMessage());
	 		}
	 	}
	 }
	 global void finish(Database.BatchableContext bc)
	 {
	 	System.debug('--------------------------------->>');
	 	System.debug('finish');
	 	
	 }
  
}