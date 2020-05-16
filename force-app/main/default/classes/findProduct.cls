public with sharing class findProduct {
    public static void finPro()
    {
    	List<Product2> proList = new List<Product2>();
    	proList = [Select name,Description from Product2 where Description like '%a%'];
    	System.debug(proList);
    }
}