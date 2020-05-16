/*Trigger class to handle all product related operation
trigger name - BulkProductTrigger on Product2 (after insert, after update, before insert, before update)
*/

public with sharing class BulkProductHandler {
   
    /*On Product to setup default Pricebook entry in the “Standard Pricebook” as 1$*/
    public static void initProductPrice(List<Product2> proList)
    {
    	if(proList.size() > 0 )
		{ 
			PriceBook2 pbk =new PriceBook2();
			pbk = [Select Id from PriceBook2 where isStandard = true];
			System.debug('Standard Price book ----------------->'+pbk);
			
			List<PriceBookEntry> pbeList = new List<PriceBookEntry>();
			
			for(Product2 proTemp : proList)
			{
				PriceBookEntry pbeObj = new PriceBookEntry();
				pbeObj.Product2Id = proTemp.Id;
				pbeObj.Pricebook2Id = pbk.Id;
				pbeObj.UnitPrice = 1;
				pbeList.add(pbeObj);    
			}
            try
            {
               upsert pbeList;
            }
            catch(DMLException de)
            {
                System.debug(de.getMessage());
            }
						
		}
		else
		{
			System.debug('---------------------------->Null Product list recieved<----------------------------');
		}
    }
}