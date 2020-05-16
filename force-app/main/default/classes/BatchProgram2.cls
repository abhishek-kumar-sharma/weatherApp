/*Batch program to delete accounts created in 10 days before and run every day at 12:00 PM*/
global without sharing class BatchProgram2 implements Schedulable{
	global void execute(System.SchedulableContext sc)
	{
		BatchProgram1 batchProgramObj = new BatchProgram1();
		/*To schedule it use the 
		System.Schedule('message',corn,classObject);
		corn expression - 	0 0 12 ? * MON-SUN *
		
		run it in execute anonymous
		BatchProgram2 batchProObject = new BatchProgram2();
		String corn = '0 0 12 ? * MON-SUN *';
		String JobId = System.schedule('Abhishek Batch Schedule',corn,batchProObject);
		System.debug(JobId);
		
		*/  
	}   
}