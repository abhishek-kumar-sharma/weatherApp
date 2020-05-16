/*
 * Created by abhishek on 16/4/18.
 */

global with sharing class SfdcToSfdcController {

    @AuraEnabled
    public static String createAccount(Account accountObject) {
        System.debug('createAccount() --->  data ---> ' + accountObject);
        if (accountObject != null && accountObject.Name != null) {
            try {
                Database.SaveResult saveResult = Database.insert(accountObject);
                if (saveResult.isSuccess() == true && saveResult.getId() != null && saveResult.getErrors().size() <= 0) {
                    return 'Account Successfully created';
                } else {
                    return 'unable to create account ';
                }

            } catch (Exception de) {
                System.debug('Exception occurred while creating account');
                return 'Exception Occurred';
            }

        } else {
            System.debug('Null Account Received ');
            return null;
        }
    }
}