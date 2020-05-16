trigger campTrigger10 on Campaign (after update,after insert) {
    if(Trigger.isUpdate)
    {
    triggerProgram10.campHandler(Trigger.new);
    }
     
}