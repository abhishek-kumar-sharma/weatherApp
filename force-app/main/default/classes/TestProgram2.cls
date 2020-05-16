/*Script ot fetch seller and tenant entered in last year*/
public with sharing class TestProgram2 {
	public static void fetchData()
	{
		List<Lead> leadList = new List<Lead>();
		date date1 = date.newInstance(2018,01,29);
		leadList = [select Name,Company,Status,Records__c from Lead where Records__c includes('Seller','Tenant') AND CreatedDate = LAST_YEAR];
		
		if(leadList.size() > 0 )
		{
			System.debug('Lead List ----> '+leadList);
		}
		else
		{
			System.debug('Null lead List recieved');
		}
	}
    
}