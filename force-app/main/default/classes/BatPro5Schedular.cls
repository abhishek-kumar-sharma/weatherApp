/*Create Batch class to create 5 new Opportunities daily and Schedule this class to run 4 times every day at after every 6 hours. 
Batch class name - */
global class BatPro5Schedular implements Schedulable {
    global void execute(System.SchedulableContext sc)
    {
        BatchProgram4 bcPro4 = new BatchProgram4();
        /*
paste it to execute anano....      
BatPro5Schedular bc = new BatPro5Schedular();
String cron = '0 0 0/6 1/1 * ? *';
String jobId = system.schedule('BatPro5', cron, bc);
System.debug('------------------------> Execute method of Schedulable '+jobId);



*/
    }

}