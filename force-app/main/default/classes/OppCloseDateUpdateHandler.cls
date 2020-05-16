/*update close date handler opportunity 
vf page name - Update_close_Date_Opp.vfp
component name - AuraProgram3VFCmpUpdateCloseDate
*/
public class OppCloseDateUpdateHandler {
    private final Opportunity oppObject;
    
    public OppCloseDateUpdateHandler(ApexPages.StandardController stdCtrl)
    {
       // oppObject  = (Opportunity)stdCtrl.getRecord();
        //System.debug('-----------> oppObject----> '+oppObject);
        
    }
    
    @AuraEnabled
    public static void updateDate(String dt,String oppID)
    {
        System.debug('Recieved data--> date-->'+dt+'opp id ---> '+oppID);
        if(dt != null && oppID != null)
        {
            Opportunity opp = new Opportunity();
            opp = [select Id,Name,closeDate from Opportunity where id =: oppId limit 1];
            System.debug('opp -------------> '+opp);
            opp.CloseDate = Date.valueOf(dt);
            upsert opp;
				           
        }
        else
        {
            System.debug('else block --------------> ');
        }
    }
    
}