/* Script to Schedule the above class to run in every 5 minutes.*/
global class BatProgram9 implements Schedulable{
    global void execute(System.SchedulableContext sc)
    {
        BatProgram8 bc8 = new BatProgram8();
        for(Integer i=0;i<60;i=i+5)
        {
            BatProgram9 bc9 = new BatProgram9();
            //String cron = '0 0/5 * 1/'+i * ? *';
            String jobId = System.schedule('Count no of contact in account'+i,'0 0 0/1 1/'+i+' * ? *',bc9);
            System.debug('-------------------------> '+jobId);
        }
    }
}
/*
Execute anan...
BatProgram9 bc9 = new BatProgram9();

bc9.execute(null);*/