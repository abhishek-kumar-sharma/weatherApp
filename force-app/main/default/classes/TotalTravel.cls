public with sharing class TotalTravel {
	public static void totalTravelHours()
	{
		/*Fetching plan list having A or F in them*/
		List<Plan__c> planList =new List<Plan__c>();
		planList = [select Name,Travel_Hours__c,Travel_Location__c from Plan__c where Travel_Location__c includes ('A','F') ];
		System.debug('Plan List ----> '+planList);
		
		Integer total_Travel_hours = 0;//variable to store total hours
		
		if(planList.size() > 0 )  
		{
			/*Calculating the total travel hours*/
			for(Plan__c planObj : planList)
			{
				total_Travel_hours += Integer.valueOf(planObj.Travel_Hours__c);
			}
			System.debug('Total Travel Hours of A and F ----> '+total_Travel_hours);
		}
		
	}
    
}