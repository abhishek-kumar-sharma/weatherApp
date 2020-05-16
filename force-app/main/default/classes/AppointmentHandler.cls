public with sharing class AppointmentHandler {
	public static void handleAppointment(List<Appointment__c> appointmentList)
	{
		/*Null check for appointment List*/
		if(appointmentList.size() > 0 )
		{

			Set<Id> docIdSet = new Set<Id>();
			Set<Id> patientIdSet = new Set<Id>();
			/*Creating Id for doctor and patient*/
			for(Appointment__c appObj : appointmentList)
			{
				if((appObj.Doctor__c != null )&&( appObj.Patient__c != null))
				{
					docIdSet.add(appObj.Doctor__c);
					patientIdSet.add(appObj.Patient__c);
				}
			}
			System.debug('------------> ID set patient'+patientIdSet);
			System.debug('------------> ID set doctor '+docIdSet);
			
			Set<Date> dateSet = new Set<Date>();
			for(Appointment__c appTemp : appointmentList)
			{
				dateSet.add(appTemp.Date__c);
			
			}
			System.debug('Date id set ------------------------> '+dateSet);
			List<Appointment__c> noOfRecord = new List<Appointment__c>();
			noOfRecord = [select Doctor__c,Date__c from Appointment__c where Doctor__c IN:docIdSet and Date__c IN:dateSet ];
			System.debug('-------------------No of records  > '+noOfRecord);
			 
			
		}
		else
		{
			System.debug('-------------------> Null Appointment List recieved <-------------------');
		}
	}
    
}