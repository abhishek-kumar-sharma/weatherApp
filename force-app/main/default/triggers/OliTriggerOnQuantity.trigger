//main trigger on oli object
//
trigger OliTriggerOnQuantity on OpportunityLineItem (before insert, before update,after update,after insert) {
    if(Trigger.isBefore)
    {
        if(Trigger.isInsert || Trigger.isUpdate)
        {
            GandhiJiHandler.manageChasma(Trigger.new);
        }
       
    }
     else if(Trigger.isAfter)
    {
        if(Trigger.isInsert || Trigger.isUpdate)
        {
            ChasmaSoldHandler.soldManager(Trigger.new);
        }
    }
    
}