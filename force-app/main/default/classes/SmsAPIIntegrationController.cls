/* class to handle SMS api msg91.com integration
* component name -- SMSIntegrationCmp*/
public with sharing class SmsAPIIntegrationController {

    @AuraEnabled
    public static void sendSMS_Apex(String senderShortName, Integer routeCode, String countryCode, Long receiverMobileNumber, String msgBody) {
        System.debug('Received data -->  \n Sender Short Name -> ' + senderShortName + 'routeCode   -> ' + routeCode + 'countryCode -> ' + countryCode + 'receiverMobileNumber -> ' + receiverMobileNumber + 'msgBody -> ' + msgBody);

        if (msgBody != null) {
            if (msgBody.containsWhitespace()) {
                //System.debug('msgBody------' + msgBody);
                msgBody = msgBody.trim();
                msgBody = msgBody.replaceAll('(\\s+)', '%20');
                // System.debug('msgBody------' + msgBody);
            }

        }

        //http://api.msg91.com/api/sendhttp.php?sender=MSGIND&route=4&mobiles=8948481570&authkey=204452AFrykH9x5aafb2f6&country=91&message=Hello! This is a test message

        Http http = new Http();
        HttpResponse httpResponse = new HttpResponse();
        HttpRequest httpRequest = new HttpRequest();
        final String authkey = '204452AFrykH9x5aafb2f6';
        String endPoint = 'http://api.msg91.com/api/sendhttp.php?sender=' + senderShortName + '&route=' + routeCode + '&mobiles=' + receiverMobileNumber + '&authkey=' + authkey + '&country=' + countryCode + '&message=' + msgBody;
        System.debug('-------------------------> End point ' + endPoint);
        httpRequest.setEndpoint(endPoint);
        httpRequest.setMethod('GET');

        /* Sending request */
        try {
            httpResponse = http.send(httpRequest);
            if (httpResponse.getStatusCode() == 200) {
                System.debug(' -----------------------------> SMS send successfully');

            } else {
                System.debug('Status code -----------------> ' + httpResponse.getStatusCode());
            }
        } catch (Exception de) {
            System.debug('Exception Occurred while sending request in apex --> ' + de.getMessage() + ' Cause --> ' + de.getCause());
        }


    }

}