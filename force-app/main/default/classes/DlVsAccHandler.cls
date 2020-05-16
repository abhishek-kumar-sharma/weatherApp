/*Trigger Name - DLHandler*/

public with sharing class DlVsAccHandler {
	public static void manageDL(List<Data_Link__c> dlList)
	{
		if(dlList.size() > 0 )
		{
			
			map<Id,String> accountVsDlClientValue = new map<Id,String>();
			for(Data_Link__c dlTemp : dlList)
			{
			
			if(dlTemp.Production_Installed__c != null && dlTemp.Production_Uninstalled__c == null)
				{
					if(!accountVsDlClientValue.containsKey(dlTemp.Account_Lookup__c))
					{
						accountVsDlClientValue.put(dlTemp.Account_Lookup__c,'Production');
						System.debug('Production Value ----> '+accountVsDlClientValue);
					}
					
				}
			 if(dlTemp.Production_Installed__c == null && dlTemp.Production_Uninstalled__c == null)
				{
					if(!accountVsDlClientValue.containsKey(dlTemp.Account_Lookup__c) && accountVsDlClientValue.get(dlTemp.Account_Lookup__c) == 'Production')
					{
						System.debug('Again Production');
						System.debug('Sandbox -----> '+accountVsDlClientValue);
					}
					else
					{
						accountVsDlClientValue.put(dlTemp.Account_Lookup__c,'Sandbox');
					}
				}
			if(dlTemp.Production_Uninstalled__c != null || dlTemp.Sandbox_Uninstalled__c != null)
				{
					if(!accountVsDlClientValue.containsKey(dlTemp.Account_Lookup__c) && (accountVsDlClientValue.get(dlTemp.Account_Lookup__c) == 'Production' || accountVsDlClientValue.get(dlTemp.Account_Lookup__c) == 'Sandbox'))
					{
						System.debug('SandBox or Production');
						System.debug('Former map sec ----> '+accountVsDlClientValue);
					}
				}
			else
				{
					accountVsDlClientValue.put(dlTemp.Account_Lookup__c,null);
					System.debug('--------> '+accountVsDlClientValue);
				}
			}
		}
		else
		{
			System.debug('NULL DL LIST RECIEVED');
		}
	}
    
}