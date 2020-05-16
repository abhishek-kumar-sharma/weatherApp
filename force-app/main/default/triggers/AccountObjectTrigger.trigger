trigger AccountObjectTrigger on Account (after insert) {
    if(Trigger.isAfter && Trigger.isInsert){
       AccountTriggerHandler.createContacts(Trigger.new);
    }
}