trigger ConcacateLastName on Contact (before insert) {
    concateHandler.concateLastName(Trigger.new);
    
}