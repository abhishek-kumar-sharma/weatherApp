global class BatProgram7 implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext bc)
    {
        String query = 'Select Name,AccountId from Contact where AccountId !=null';
        try
        {	System.debug('$$$$$$$$$');
            return Database.getQueryLocator(query);
        }
        catch(Exception e)
        {
            System.debug('message'+e.getMessage());
            return NULL;
        }
    }
    
    global void execute(Database.BatchableContext bc, List<Contact> conList)
    {
        System.debug('csssssssssssssssssssssssssssssssssssssssssssssssssssssss');
        if(conList.size() > 0 )
        {
            System.debug('------------------------------------- batch'+conList);
            for(Contact con : conList)
            {
                System.debug(con.Name);
            }
        }
        else
        {
            System.debug('----------------------NULL CONATACT LIST RECIEVED----------------');
        }
    }
    global void finish(Database.BatchableContext bc)
    {
        
    }
    
}