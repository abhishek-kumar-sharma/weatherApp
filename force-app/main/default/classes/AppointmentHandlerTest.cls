@isTest
private class AppointmentHandlerTest {
    @isTest
    private static void handleAppointmentTest()
    {
    	Doctor__c doctorObject = new Doctor__c();
    	doctorObject.Name = 'Doctor Name Test';
    	
    	Patient__c patientObject = new Patient__c();
    	patientObject.Name = 'patient name';
    	patientObject.Age__c = 16;
    	
    	Appointment__c appointmentObject = new Appointment__c();
    	appointmentObject.Date__c = date.today();
    	appointmentObject.Doctor__c = doctorObject.Id;
    	appointmentObject.Patient__c = patientObject.Id;
    	
    	Appointment__c appointmentObject1 = new Appointment__c();
    	appointmentObject1.Date__c = date.today();
    	
    	Test.startTest();
    	insert doctorObject;
    	insert patientObject;
    	insert appointmentObject;
    	insert appointmentObject1;
    	Test.stopTest();
    	
    	
    }
}