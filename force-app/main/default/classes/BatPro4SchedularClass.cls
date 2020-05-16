global without sharing class BatPro4SchedularClass implements Schedulable {
    
    global void execute(System.SchedulableContext sc)
    {
        BatchProgram4 bc = new BatchProgram4();
        /* run it in execute anao..
* 
BatPro4SchedularClass bc = new BatPro4SchedularClass();
String cron = '0 0 1 1/1 * ? *';
String jobId = system.schedule('BatPro4', cron, bc);
System.debug('------------------------> Execute method of Schedulable '+jobId);


*/
    }
    
}