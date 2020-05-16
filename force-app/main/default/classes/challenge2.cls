public class challenge2 {
	public static void copyAddress()
	{
		Contact con = [Select Shipping_Address__c, Id, AccountId From Contact where copy_Address_to_All_Contact__c=true ];
		List<Contact> conAll = [select accountid,Shipping_Address__c from contact];
		
		for(Contact conTemp : conAll)
		{
			if(con.AccountId == conTemp.AccountId)
			{
				conTemp.Shipping_Address__c=con.Shipping_Address__c;
			}
		}
		System.debug('success');
		update conAll;
		
	}
    
}