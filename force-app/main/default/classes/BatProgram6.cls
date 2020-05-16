/*
Create Batch class to create 5 new Opportunities daily
Schedule the above class to run 4 times every day at after every 6 hours. 
Write a Script to delete the above Schedule Jobs
*/
global class BatProgram6 {
    global static void stopOppCreation()
    {
        List<CronTrigger> cronList = new List<CronTrigger>();
        cronList = [SELECT CronExpression,CronJobDetail.Name,Id,NextFireTime,State FROM CronTrigger where CronExpression = '0 0 0/6 1/1 * ? *' AND CronJobDetail.Name = 'BatPro5'];
        
        for(CronTrigger cron : cronList)
        {
            System.debug(cron.CronJobDetail.Name);
        }
        
        for(CronTrigger cronTemp : cronList)
        {
            if(cronTemp.State == 'WAITING')
            {
                System.debug('JOB NAME ----> '+cronTemp.CronJobDetail.Name);
                System.debug('Status of job -----> '+cronTemp.State);
                System.abortJob(cronTemp.Id); 
            }
        }
        System.debug(cronList);
    }
    
    
}


// execute ana...... BatProgram6.stopOppCreation();