public with sharing class ProductCodeHandler {
	public static void addCodeToProduct(List<Product2> proList)
	{
		/*Performing the null check for the recived product list*/
		if(proList.size() > 0 )
		{
			/*Performing operation for product code*/
			for(Product2 proTemp : proList)
			{
				if(proTemp.ProductCode != null)
				{
					proTemp.ProductCode = 'Code--' + proTemp.ProductCode;
				}
				else
				{
					System.debug('Unable to insert product code -------------->');
				}
			}
			upsert proList;
		}
		else
		{
			System.debug('---------------->Null Product List recived<----------------');
		}
		
		
	}
    
}