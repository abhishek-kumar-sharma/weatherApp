/*
 
Page name - BatProgram12
Controller - BatProgram12Controller
*/

public class BatProgram12Controller {
    public List<CronTrigger> jobList {set;get;}
    public String delRow{set;get;}
    
    public BatProgram12Controller()
    {
        fetchJob();
    }
    
    public void fetchJob()
    {
        jobList = [SELECT CronExpression,CronJobDetail.Name,NextFireTime,StartTime,State FROM CronTrigger where state = 'Waiting'];
        if(jobList.size() > 0 )
        {
            System.debug('Data loaded') ;
        }
        else
        {
            System.debug('Unable to load data');
        }
    }
    
    public PageReference deleteHandler()
    {
        delRow = ApexPages.currentPage().getParameters().get('DelRowId');
        System.debug('---------------> Delete Job Id '+delRow);
        if(delRow != null)
        {
        System.abortJob(delRow);
        }
        else
        {
            System.debug('Null Id recieved ........ Unable to Abort the job');
        }
        return null;
    }
    
}