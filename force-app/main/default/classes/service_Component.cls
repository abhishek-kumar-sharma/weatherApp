/**
 * Created by ABHISHEK on 02-05-2019.
 */

public with sharing class service_Component {
    /**
     * Method to fetch data from Account
     * Will get 10 Account first
     */
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContact_With_All_Fields_Apex(Integer endAt, Integer startFrom) {
        try {
            if (startFrom != null && endAt != null) {
                /**
                 * Initializing the list and variables
                 */
                List<Contact> contactList = new List<Contact>();
                contactList = [SELECT Id,Name,Owner.Email,Owner.Name,Owner.Username FROM Contact ORDER BY Name LIMIT:endAt OFFSET:startFrom];
                return contactList;
            }
            return null;
        } catch (Exception exce) {
            throw new service_ComponentException(exce.getMessage());
        }

    }


    private class service_ComponentException extends Exception {

    }
}