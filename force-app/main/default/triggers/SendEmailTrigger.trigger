/*Trigger to send email to contact owner and contact when a contact is created
Written by Abhishek kumar sharma
date 17-january-2018*/
trigger SendEmailTrigger on Contact (after insert ) {
    SendEmailHandler.sendEmail(Trigger.new);
    
}