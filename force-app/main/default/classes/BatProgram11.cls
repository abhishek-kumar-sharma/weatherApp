/*Write a Script to delete the above Schedule Jobs with for loop batProgram 8*/
global class BatProgram11 {
    
    global void deactiveSchedule()
    {
        List<CronTrigger> jobList = new List<CronTrigger>();
        jobList = [select  id from CronTrigger];
        if(jobList.size() > 0 )
        {
            for(CronTrigger crontemp : jobList)
            {
                System.debug('Disabled job Id '+crontemp.Id);
                System.abortJob(crontemp.Id);
            }
        }
    }
    
}