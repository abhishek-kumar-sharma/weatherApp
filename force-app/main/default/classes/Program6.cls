public class Program6 {

		public static void productCreation()
		{
			List<Product2> proList = new List<Product2>();
			
			for(integer i=0;i<10;i++)
			{
				Product2 proObj = new Product2();
				proObj.Name	= 'Product '+i;
				proObj.Description = 'This is product no. '+i;
				proObj.Family = 'Family of product is  '+i;
				proList.add(proObj);
				System.debug('adding product object to list ----> object no  '+i);
			}
			insert proList;
			System.debug('Final ----> '+prolist);
		}
		    
}