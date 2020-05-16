/* Trigger to create orders on opportunity stage changes to 'send orders' */
trigger BulkOpportunityTrigger on Opportunity (after update,before insert) {

    if(Trigger.isInsert && Trigger.isBefore)
    {
        /* Method  to check stage name is not send order at opportunity creation time*/
       BulkOpportunityOrderHandler.checkStageNameBeforeInsert(Trigger.new);
    }
    if(Trigger.isUpdate && Trigger.isAfter)
    {
        /*Method to create order when stage value is send order*/
        BulkOpportunityOrderHandler.createOpportunityOrder(Trigger.newMap,Trigger.oldMap); 
    }
  
}