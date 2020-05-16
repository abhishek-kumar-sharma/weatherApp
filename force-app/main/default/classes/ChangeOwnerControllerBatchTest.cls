@IsTest
private class ChangeOwnerControllerBatchTest {
    static testMethod void testBehavior() {

        Account acc = new Account();
        acc.Name  = 'test acc';
        insert acc;


        Test.startTest();
        ChangeOwnerControllerBatch.changeOwnerId_Apex(acc.Id,'Account');
        Test.stopTest();

    }
}