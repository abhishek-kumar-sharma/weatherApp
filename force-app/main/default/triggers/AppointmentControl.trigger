/*Trigger to hanlde the appointment 
Written by Abhishek kumar Sharma
Date 15 - JAN - 2018 */

trigger AppointmentControl on Appointment__c (before insert, before update) {
    AppointmentHandler.handleAppointment(Trigger.new);
    
}