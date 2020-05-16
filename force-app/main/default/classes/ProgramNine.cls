public with sharing class ProgramNine {
    public static void contactEmailFetch()
    {
    	List<Contact> conList = new List<Contact>();
    	conList = [select Name,Email from Contact where Email =: UserInfo.getUserEmail()];
    	if(conList.size() > 0 )
    	{
    		System.debug(conList);
    	}
    	else
    	{
    		System.debug('NULL LIST RECIEVED...');
    	}
    	
    }
}