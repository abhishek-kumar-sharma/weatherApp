/*Trigger on Campaign Bulkify test*/
trigger BulkCampaignTrigger on Campaign (after insert, after update, before insert, before update) {
    
    if(Trigger.isUpdate)
    {
       BulkCampaignTriggerHandler.closeOpportunityOnCampaign(Trigger.new);
    }
    if(Trigger.isInsert)
    {
        BulkCampaignTriggerHandler.closeOpportunityOnCampaign(Trigger.new);
    }
    
}