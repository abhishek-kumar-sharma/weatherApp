trigger ContactAddressCopy on Contact (after update, before insert) {
    ContactAddressCopyHandler.addressCopy(Trigger.new);
}