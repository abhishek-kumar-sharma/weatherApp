trigger DLHandler on Data_Link__c (after insert, after update) {
DlVsAccHandler.manageDL(Trigger.new);    
}