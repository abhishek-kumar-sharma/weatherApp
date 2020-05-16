/*Create a new multiplicklist field on lead "Records" [Buyer, Seller, Tenant , Landloard]. Write script to fetch all the Sellers and Tenant which were entered in last year.*/


public with sharing class Test2 {
    public static void fetchSellerAndTenant()
    {
    	List<Lead> leadList = new List<Lead>();
    	leadList = [Select Name,Records__c,CreatedDate from Lead where CreatedDate = LAST_N_DAYS:365 AND Records__c INCLUDES ('Tenant','Buyer')];
    	Integer i=1;
    	for(Lead leadTemp : leadList)
    	{
    		System.debug('------------ Record No '+i+'----------');
    		System.debug('Name -> '+leadTemp.Name);
    		System.debug('Record Created date ->'+leadTemp.CreatedDate);
    		System.debug('Records -> '+leadTemp.Records__c);
    		i++;
    	}
    	
    }
}