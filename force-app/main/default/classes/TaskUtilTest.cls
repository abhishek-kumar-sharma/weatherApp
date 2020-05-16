@isTest
private class TaskUtilTest {
    @isTest static void testTaskPriority() {
        String pri = TaskUtil.getTaskPriority('NY');
        System.assertEquals('Normal', pri);
    }
     @isTest static void testTaskPriority_01() {
        String pri = TaskUtil.getTaskPriority('CA');
        System.assertEquals('High', pri);
        //System.equals();
    }
    @isTest static void testTaskPriority_02() {
        String pri = TaskUtil.getTaskPriority('CAA');
        System.assertEquals(null, pri);
    }
}