/*Trigger on Account to add or remove the  contact form account after insert or update
Written by abhishek kumar sharma
date 16-january-2018*/

trigger AccountTrigger on Account (after insert, after update) {
    if(trigger.isInsert)
    {
   accountContactHandler.addContact(Trigger.new);
    }
    if(trigger.isUpdate)
    {
     accountContactHandler.manageContact(Trigger.new,Trigger.Old);       
    }
    
}