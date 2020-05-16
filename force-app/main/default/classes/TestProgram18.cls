public with sharing class TestProgram18 {
	public static void createLeadAndProduct()
	{
		List<Lead> leadList = new List<Lead>();
		List<Product2> proList = new List<Product2>();
		for(Integer i=0;i<3;i++)
		{
			Lead leadObj = new Lead();
			leadObj.LastName = 'Test Pro 18 '+i;   
			leadObj.Company = 'ca';
			leadObj.Status = 'Working - Contacted';
			leadList.add(leadObj);
		}
		try
		{  
			insert leadList;
			System.debug('--------> '+leadList);
		}
		catch(DMLException de)
		{
			System.debug(de.getMessage());
		}
		
		Integer counter =0 ;
		for(Integer i=0;i<5;i++)
		{
			Product2 proObj = new Product2();
			proObj.Name = 'Product 18 '+i;
			if(counter >=2)
			{
				counter = 0;
			}
			proObj.LeadLookupProduct__c =leadList[counter].id;
			proObj.IsActive = true;
			proList.add(proObj);
		}
		try
		{
			insert proList;
			System.debug('--------> Product List '+proList);
		}
		catch(DMLException de)
		{
			System.debug(de.getMessage());
		}
	}
    
}