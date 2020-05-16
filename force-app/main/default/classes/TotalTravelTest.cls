@isTest private class TotalTravelTest {
    @isTest static void totalTravelHoursTest()
    {
        
        Plan__c plan = new Plan__c();
        plan.Name = 'sdngfsjdk';
        plan.Travel_Hours__c = 2;
        plan.Travel_Location__c = 'A;F';
        insert plan;
        System.debug(plan.Travel_Location__c);
        Test.startTest();
        TotalTravel.totalTravelHours();
        Test.stopTest();
    }

}