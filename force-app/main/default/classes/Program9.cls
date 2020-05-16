public with sharing class Program9 {
	public static void workingIn()
	{
     	AggregateResult totalEmployees=[select Sum(NumberOfEmployees) employee from Account where Working_in__c includes ('ASIA','NA')];
    	integer employee=   Integer.valueof( totalEmployees.get('employee'));     
      	System.debug('total employees are '+employee);
	}
    
}