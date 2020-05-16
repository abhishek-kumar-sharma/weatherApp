public class createProduct {
	public  static void createProduct()
	{
		List<Account> accList = new List<Account>();
		for(integer i=0; i<100;i++)
		{
			Account accObj = new Account();
			accObj.Name='Trigger Account'+i;
		}
	}
    
}