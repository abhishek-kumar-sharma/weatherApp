/*Create a batch Class which should run every day 00:00 and fetch all the Leads created yesteday not having a Phone number. 
Send an Email to the system Admin with the list of those Leads with details*/
global class BatProgram12 implements Database.Batchable<sObject>{
    global Database.QueryLocator start(Database.BatchableContext bc)
    {
        String query = 'SELECT Company,CreatedDate,Email,Id,MobilePhone,Name,OwnerId FROM Lead WHERE MobilePhone = null AND CreatedDate = YESTERDAY' ;
        return Database.getQueryLocator(query);
        
    }
    global void execute(Database.BatchableContext bc ,List<Lead> leadList)
    {
        if(leadList.size() > 0 )
        {
            List<User> userList =  [select Email,isActive,Id from User where Profile.Name = 'System Administrator' AND isActive=true];
            
            List<String> sysEmailList = new List<String>();
            for(User userTemp : userList)
            {
              sysEmailList.add(userTemp.Email);
            }
            
            Messaging.SingleEmailMessage semail = new Messaging.SingleEmailMessage();
            semail.setToAddresses(sysEmailList);
            semail.setSubject('Lead list Yesterday');
            
            string bodyCreation;
            for(Lead leadTemp : leadList)
            {
                bodyCreation +=leadTemp.Name+' '+leadTemp.Email+' '+leadTemp.CreatedDate+' '+leadTemp.OwnerId +'$$';
            }
            semail.setPlainTextBody(bodyCreation);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[]{semail});
            
        }
        else
        {
            System.debug('Null list Recieved');
        }
    }
    global void finish(Database.BatchableContext bc)
    {
        System.debug('Finished ----------------------> ');
    }
}



/*BatProgram12 bc12 = new BatProgram12();
System.debug('----------> exe'+Database.executeBatch(bc12));*/