public  class Program16 {
    
public void addCustomPB()
{
	//creating Price book 
Pricebook2 myPriceBook = new Pricebook2(Name = 'Algo Pricebook',IsActive = true);
insert myPriceBook;

//Creating 10 Product
	
	List<Product2> proList = new List<Product2>();
	for(integer i=0;i<10;i++)
	{
		Product2 proObj = new Product2();
		proObj.Name='Custom Product'+i;
		proObj.IsActive=true;
		proList.add(proObj);
		
	}
	insert proList;
	
	//finding id of standard price book
	
	Pricebook2 pbId = [select id from Pricebook2 where isStandard=true ];
	//System.debug('done done done ----------> '+pbId);
	
	//creating pricebookentry for relating Product and pricebook
	List<PricebookEntry> pbeList =new List<PricebookEntry>();
	
	Pricebook2 pbk=[select Id from Pricebook2 where IsStandard=true];
	List<PricebookEntry> pricebookentry1=new List<PricebookEntry>();
     
     //insert with different id
     for(Product2 pro:proList) 
     {
           PricebookEntry pbe= new PricebookEntry();
       	   pbe.Pricebook2Id=pbId.Id;
       	   pbe.Product2Id= pro.id;  
	       pbe.isActive=true;
	       pbe.UseStandardPrice =false; 
	       pbe.UnitPrice=50;
	       pricebookentry1.add(pbe);
     }
     insert pricebookentry1;
     System.debug('Status ----> '+pricebookentry1);
     
     
     //inserting into custom price book
     List<PricebookEntry> customList = new List<PricebookEntry>();
     
     for(Product2 proTemp : proList)
     {
     	PricebookEntry cPbe = new PricebookEntry();
     	cPbe.Pricebook2Id=myPriceBook.Id;
     	cPbe.Product2Id=proTemp.Id;
     	cPbe.isActive=true;
     	cPbe.UnitPrice=56;
     	customList.add(cPbe);
     	
     }
     insert customList;
     
     
	System.debug('Status of custom entry -----> '+customList);
	
	
	
}
}