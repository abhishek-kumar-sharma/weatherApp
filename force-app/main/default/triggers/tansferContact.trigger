trigger tansferContact on Contact (before insert) {
    contactTransferHandler.transferContact(Trigger.new);
    
}