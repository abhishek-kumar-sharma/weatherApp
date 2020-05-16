/*Trigger on product to handle all the bulk data*/
trigger BulkProductTrigger on Product2 (after insert, after update, before insert, before update) {
    
    if(Trigger.isBefore)
    {
        if(Trigger.isInsert || Trigger.isUpdate)
        {
            //BulkProductHandler.initProductPrice(Trigger.new);
        }
    }  
    
}