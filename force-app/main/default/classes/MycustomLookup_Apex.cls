/**
 * Created by abhishek on 9/3/18.
 * class to handle MyCustomLookup component
 * account id lookup on opportunity
 */

public with sharing class MycustomLookup_Apex
{
    @AuraEnabled
    public static List<AccountWrapper> getAccountData_Apex(String keyword)
    {
        if(keyword == null || keyword == 'undefined' || keyword == 'null')
        {
            return null;
        }
        else
        {
            /* wrapper list to return*/
            List<AccountWrapper> wrapperList = new List<AccountWrapper>();
            /* query formation */
            String queryString = 'SELECT ID,NAME FROM ACCOUNT WHERE NAME LIKE \'%'+keyword+'%\'';
            System.debug('Created query ----> ' +queryString);
            try
            {
                /* fetching account */
                List<Account> accList = new List<Account>();
                accList = Database.query(queryString);
                if(accList.size() > 0 )
                {
                    /*Filling wrapper List*/
                    for (Account accObject : accList)
                    {
                        AccountWrapper accountWrapper = new AccountWrapper();
                        accountWrapper.accName = accObject.Name;
                        accountWrapper.accId  =accObject.Id;
                        wrapperList.add(accountWrapper);
                    }
                    if(wrapperList.size() > 0 )
                    {
                        /* Returning wrapper list*/
                        System.debug('Returned wraapper List ------> ' +wrapperList);
                        return wrapperList;
                    }
                    else
                    {
                        System.debug(' >> --------------> Null Wrapper List');
                        return null;
                    }
                }
                else
                {
                    System.debug('>>---------------> Null Account List ');
                    return null;
                }

            }
            catch (Exception de)
            {
                System.debug('Exception occurred ---> Cause of Exception --> '+de.getCause()+' Line Number ---> '+de.getLineNumber()+' Message --> '+de.getMessage());
                return null;
            }
        }
    }




    /*  Wrapper class to bind Account id with Account name */
    private class AccountWrapper
    {
        @AuraEnabled
        public String accName;
        @AuraEnabled
        public String accId;
    }

}