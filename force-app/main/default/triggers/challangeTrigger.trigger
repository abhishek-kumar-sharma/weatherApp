trigger challangeTrigger on policy__c (after update) {
    PolicyHandler.updatePolicy(Trigger.new);
    
}