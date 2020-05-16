/**
 * Created by Abhishek Kumar Sharma  on 6/11/2018.
 *
 */

public with sharing class CalenderDemoControllerApex {

    /* Method to get full calender of selected date range */
    @AuraEnabled
    public static String getFullCalender_Apex(String sdate, String edate) {
        try {

            Date startDate = Date.valueOf(sdate);
            Date endDate = Date.valueOf(edate);

            /*System.debug('sDate ---> ' + sdate);
            System.debug('eDate ---> ' + edate);*/

            Date tempStartDate = Date.valueOf(sdate);
            Date tempEndDate = Date.valueOf(edate);

            System.debug('tempStartDate ---> ' + tempStartDate);
            System.debug('tempEndDate ---> ' + tempEndDate);

            return 'aa gya';
        } catch (Exception exce) {
            System.debug('Exception occurred \nMessage -->' + exce.getMessage() + ' Cause --->' + exce.getCause() + ' Line Number -->' + exce.getLineNumber());
            return 'Exception';
        }

    }

    class DateWrapper{


    }

}