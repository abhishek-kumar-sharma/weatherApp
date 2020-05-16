/**
 * Created by ABHISHEK on 11-09-2019.
 */

public with sharing class helloEx {
    private final Account user_Acc;
    public helloEx(ApexPages.StandardController stdCtrl){
        this.user_Acc = (Account)stdCtrl.getRecord();
    }
    public String getGreeting() {
        return 'Hello ';
    }
    public static void helloWorld(){
        System.debug('Hello world called');
    }


}