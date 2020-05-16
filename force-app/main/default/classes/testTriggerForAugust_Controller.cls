/**
 * Created by ABHISHEK on 24-08-2019.
 */

public with sharing class testTriggerForAugust_Controller {
    public static void testetetetet(List<Contact> allList) {
        List<Id> AccId = new List<Id>();
        for (Contact temp : allList) {
            AccId.add(temp.AccountId);
        }

        Integer count = 0;
        List <Account> ListAcc = new List<Account>();
        ListAcc = [Select Id,Name, (Select id,LastName from Contacts) from Account where id IN :AccId];

        Map<Account, List<Contact>> mapIns = new Map<Account, List<Contact>>();
        for (Account ac : ListAcc) {
            mapIns.put(ac, ac.Contacts);
        }

        System.debug('mapIns' + mapIns);

        List<Contact> tempCon = new List<Contact>();
        for (Account temp : mapIns.keySet()) {
            List<Contact> tempCon1 = mapIns.get(temp);
            if (tempCon1.size() < 11) { // we need the parent contact
                Contact c = new Contact();
                c.AccountId = temp.Id;
                c.LastName = 'LastName';
                tempCon.add(c);
                System.debug('This is right');
            } else {
                Contact c = new Contact();
                c.addError('This is not valid');
                break;
                System.debug('This is wrong');
            }
        }
        insert tempCon;
        System.debug('Final Value' + tempCon);

    }
}