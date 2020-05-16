public with sharing class AuraProgram3Controller {
    @AuraEnabled
    public static List<sobject> getAllOpportunity()
    {
    	List<sobject> oppList =  new List<sobject>();
    	oppList = [SELECT Id,Name,StageName,CloseDate FROM OPPORTUNITY LIMIT 100];
    	System.debug('returned opportunity List --> '+oppList);
    	return oppList;
    }
}