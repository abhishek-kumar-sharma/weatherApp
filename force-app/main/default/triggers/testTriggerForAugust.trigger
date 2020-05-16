/**
 * Created by ABHISHEK on 24-08-2019.
 */

trigger testTriggerForAugust on Contact (after insert) {
    if(Trigger.isAfter && Trigger.isInsert)
    {
        testTriggerForAugust_Controller.testetetetet(Trigger.New);
    }
}