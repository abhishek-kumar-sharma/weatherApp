@isTest private class Program22Test {
    @isTest private static void oppCloneTest()
    {
        Test.startTest();
        Opportunity op = new Opportunity();
        op.Name = 'kk';
        op.closeDate = date.today();
        op.StageName = 'Prospecting';
        insert op;
        Test.stopTest();
    }

}