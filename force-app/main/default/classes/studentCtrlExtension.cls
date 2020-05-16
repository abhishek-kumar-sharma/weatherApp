/**
 * Created by ABHISHEK on 01-03-2019.
 */

public with sharing class studentCtrlExtension {
    public String User_Name {set;get;}
    public String Password {set;get;}
    public ECSV__Student__c loginStudent {set;get;}
    public List<ECSV__Student__c> students {set;get;}
    public studentCtrlExtension(ApexPages.StandardController controller){
        loginStudent  = new ECSV__Student__c();
    }
    public PageReference checkLogin_Details()
    {
        students = [select Id,ECSV__User_Name__c,ECSV__Password__c from ECSV__Student__c where ECSV__User_Name__c= 'abhishek.1514004@kiet.edu'];
        System.debug(students);
        return null;
    }
}