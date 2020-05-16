@isTest private class TestRestrictContactByName {
    @isTest private static void checkCon()
    {
        Contact con = new Contact();
        con.LastName = 'INVALIDNAME';
        insert con;
    }

}