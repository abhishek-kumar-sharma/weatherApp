public with sharing class OliHandler {
    public static void checkProduct(List<Opportunity> oliList)
    {
    	if(oliList.size() > 0 )
    	{
    		for(Opportunity oliTemp : oliList)
    		{
    			if(oliTemp.Count__c > 2)
    			{
    				oliTemp.addError('Maximum two product allowed');
    			}
    		}
    	}
    }
}