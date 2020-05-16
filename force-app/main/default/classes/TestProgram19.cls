public with sharing class TestProgram19 {
    public static void findUserLead()
    {
    	/*Fetching all the user from system*/
    	List<User> userList = new List<User>();
    	userList = [select Name,Username from User ];
    	System.debug('User List ---> '+userList);
         	
    	/*fetching all the lead on basic of username (OwnerId)*/
    	List<Lead> leadList = new List<Lead>();
    	Datetime  date1 = Datetime.newInstance(2018,01,01);
    	Datetime date2 = Datetime.newInstance(2018,01,31);
    	
    	//only fetch open leads
    	
    	leadList = [select Name,OwnerId,CreatedDate from Lead where OwnerId IN: userList AND CreatedDate >=: date1 AND CreatedDate <=: date2 ];
    	System.debug('Lead List -------------> '+leadList);
    	if(leadList.size() > 0 )
    	{
    		/*map for storing ownerID and no of lead associated with ownerid*/
    		map<Id,Integer> leadVsOwnerIdMap = new map<Id,Integer>();
    		for(Lead leadTemp : leadList)
    		{
    			if(!leadVsOwnerIdMap.containsKey(leadTemp.OwnerId))
    			{
    				leadVsOwnerIdMap.put(leadTemp.OwnerId,1);
    			}
    			else
    			{
    				Integer counter = leadVsOwnerIdMap.get(leadTemp.OwnerId);
    				counter++;
    				leadVsOwnerIdMap.put(leadTemp.OwnerId,counter);
    			}
    		}
    		
    		
    		/*user account set to store id*/
    		Set<Id> userIdSet = new Set<Id>();
    		System.debug('Owner Having more than 20 lead allocation');
    		for(Lead leadTemp : leadList)
    		{
    			if(leadVsOwnerIdMap.get(leadTemp.OwnerId) >= 20)
    			{
    				userIdSet.add(leadTemp.OwnerId);
    			}
    			
    		}
    		/*Printing user name from user id set*/
    		for(User udr : userList)
    		{
    			if(userIdSet.contains(udr.Id))
    			{
    				System.debug('Name -----> '+udr.Name);
    			}
       		}
    		
    	}
    	
    	
    	
    	
    }
}