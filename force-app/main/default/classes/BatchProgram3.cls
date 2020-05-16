/*Batch program deactivate the batch class to delete accounts created in 10 days before and run every day at 12:00 PM*/
global without sharing class BatchProgram3{
	
	global static void stopBatchExecution()
	{
		List<CronTrigger> activeBatchList = new List<CronTrigger>();
		//fetching specific batch by corn expression
		activeBatchList = [SELECT CreatedById,CreatedDate,CronExpression,CronJobDetail.Name,EndTime,Id,NextFireTime,OwnerId,PreviousFireTime,StartTime,State,TimesTriggered FROM CronTrigger WHERE CronExpression = '0 0 12 ? * MON-SUN *'];
		System.debug('------------------------> '+activeBatchList);
		for(CronTrigger cronTemp : activeBatchList)
		{
			System.debug(cronTemp.Id);
			System.debug(cronTemp.CronJobDetail.name);
			if(cronTemp.CronJobDetail.name == 'Abhishek Batch Schedule')
			System.abortJob(cronTemp.Id);
		}
		System.debug('Deactivation success');
		
		
	}
	
	
    
}