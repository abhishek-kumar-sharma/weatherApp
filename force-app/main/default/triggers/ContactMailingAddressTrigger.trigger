/*Trigger to throw error when a Contact is getting inserted in Salesforce having Country
 same as User country and Company country
*/
trigger ContactMailingAddressTrigger on Contact (before insert, before update) {
    ContactMailingAddressChecker.checkMailingAddress(Trigger.new);
    
}