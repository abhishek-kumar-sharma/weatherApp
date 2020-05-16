/*Class  for trigger Accouunt Trigger*/
public with sharing class accountContactHandler {
    public static void addContact(List<Account> accList) {
        /*Null check for recieved account list*/
        if (accList.size() > 0) {
            Integer loop_var = 0 ;
            /*Craeting contact for Account*/
            List<Contact> conList = new List<contact>();

            for (Account accTemp : accList) {
                for (loop_var = 0; loop_var < accTemp.NumberOfEmployees; loop_var++) {
                    Contact conTemp = new Contact();
                    conTemp.FirstName = 'Trigger';
                    conTemp.LastName = 'New Contact ' + loop_var;
                    conTemp.AccountId = accTemp.Id;
                    conList.add(conTemp);

                }
            }/*End of for loop*/

            try {
                insert conList;
                System.debug('-------------------Contact list------>' + conList);
            } catch (DmlException dml) {
                System.debug('Unable to create contact DML Exception Occoured');
            }


        }/*end of if block*/ else {
            System.debug('---------------------------->Null Account list recieved<----------------------------');
        }

    }/*end of addContact() method*/


    /*Method to handle no of Employee update*/

    public static void manageContact(List<Account> newAccList, List<Account> oldAccList) {
        /*Null check for recieved account list*/
        if (newAccList.size() > 0 && oldAccList.size() > 0) {
            /*Creating map of changes in no of employee*/
            Map<Id, Integer> oldNoOfEmpMap = new Map<Id, Integer>();
            Map<Id, Integer> newNoOfEmpMap = new Map<Id, Integer>();
            map<Id, list<Contact>> acoountIdVsContactListMap = new map<Id, list<Contact>>();

            set<ID> accountIdSet = new set<ID>();

            List<Contact> contactList = new List<Contact>();
            List<Contact> deleteContactList = new List<Contact>();

            for (Account oldAccTemp : oldAccList) {
                if (!oldNoOfEmpMap.containsKey(oldAccTemp.Id)) {
                    oldNoOfEmpMap.put(oldAccTemp.Id, oldAccTemp.NumberOfEmployees);
                }
                System.debug('------------------ Old map values ' + oldNoOfEmpMap);
            }
            for (Account newAccTemp : newAccList) {
                accountIdSet.add(newAccTemp.Id);
                if (!newNoOfEmpMap.containsKey(newAccTemp.Id)) {
                    newNoOfEmpMap.put(newAccTemp.Id, newAccTemp.NumberOfEmployees);
                }
            }

            System.debug('----------------- new map values ' + newNoOfEmpMap);

            /*for(Account accTemp : oldAccList)
{
Integer value = oldNoOfEmpMap.get(accTemp.Id);
System.debug('-----------------------------> access map value' +value);

}*/
            if (accountIdSet.size() > 0) {
                contactList = [
                        SELECT
                                Id,
                                AccountId
                        FROM Contact
                        WHERE AccountId IN:accountIdSet
                ];

                if (contactList.size() > 0) {
                    for (Contact contact : contactList) {
                        if (acoountIdVsContactListMap.get(contact.AccountId) == null) {
                            acoountIdVsContactListMap.put(contact.AccountId, new list<Contact>());
                        }
                        acoountIdVsContactListMap.get(contact.AccountId).add(contact);
                    }
                }
            }

            List<Contact> conList = new List<Contact>();
            List<Contact> delConList = new List<Contact>();
            for (Account accTemp : oldAccList) {
                Integer oldValueOfEmp = oldNoOfEmpMap.get(accTemp.Id);
                Integer newValueOfEmp = newNoOfEmpMap.get(accTemp.Id);
                if (oldValueOfEmp <= newValueOfEmp) {
                    Integer newNoOfContact = oldValueOFeMP - newValueOfEmp;
                    for (Integer i = 0; i < newNoOfContact; i++) {
                        Contact conObj = new Contact();
                        ConObj.LastName = 'Newly Added contact' + i;
                        conObj.AccountId = accTemp.Id;
                        conList.add(conObj);
                    }
                } else {
                    Integer delContactNo = oldValueOfEmp - newValueOfEmp;
                    list<Contact> accountVsContactList = new list<Contact>();
                    accountVsContactList = acoountIdVsContactListMap.get(accTemp.Id);
                    for (integer i = 0; i < delContactNo; i++) {
                        deleteContactList.add(accountVsContactList[i]);
                    }
                }
            }
            if (deleteContactList.size() > 0) {
                System.debug('Size of delete contact list ' + deleteContactList.size());
                insert conList;
                delete deleteContactList;
            }
        }
    }
}