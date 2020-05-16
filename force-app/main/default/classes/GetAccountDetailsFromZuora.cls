/**
 * @Created by ABHISHEK on 12-06-2019.
 * @description Created to get the account all details from zuora in JSON format
 * @param accountId of zuora or
 * @param account  number of zuora
 *
 */

public with sharing class GetAccountDetailsFromZuora {
    public static String getAccessToken() {
        try {
            String client_id = 'd6f28200-7e18-4eb5-b527-eb99fe57c27a';
            String client_secret = '6fKf4r9V5+YMBvoBhxWV5ATLgpk/e=sj0xaxgnA';
            String grant_type = 'client_credentials';
            String body = 'client_id=' + client_id + '&client_secret=' + client_secret + '&grant_type=client_credentials' ;

            HttpRequest httpRequest = new HttpRequest();
            httpRequest.setTimeout(120000);
            httpRequest.setMethod('POST');
            httpRequest.setEndpoint('https://rest.apisandbox.zuora.com/oauth/token');
            httpRequest.setBody(body);
            Http http = new Http();
            HttpResponse httpResponse = http.send(httpRequest);
            if (httpResponse != null) {
                Map<String, Object> returnedData = (Map<String, Object>) JSON.deserializeUntyped(httpResponse.getBody());
                return String.valueOf(returnedData.get('access_token'));
            }
            return null;

        } catch (Exception exce) {
            System.debug('Exception occurred while getting the access token from zuora. \n Message ::'
                    + exce.getMessage() + ' \n Cause :: ' + exce.getCause() + ' \n Line Number ::' +
                    exce.getLineNumber() + ' \n Stack Traces ::' + exce.getStackTraceString());
            return null;
        }
    }
    public static void getAccountDetails(String accountId) {
        try {
            String accessToken = GetAccountDetailsFromZuora.getAccessToken();
            if (String.isNotBlank(accessToken) && String.isNotBlank(accountId)) {
                String auth = 'Bearer ' + accessToken;
                String endpoint = 'https://rest.apisandbox.zuora.com/v1/accounts/' + accountId + '/summary';
                HttpRequest httpRequest = new HttpRequest();
                httpRequest.setMethod('GET');
                httpRequest.setHeader('Authorization', auth);
                httpRequest.setHeader('Content-Type', 'application/json');
                httpRequest.setEndpoint(endpoint);
                Http http = new Http();
                HttpResponse httpResponse = http.send(httpRequest);
                if (httpResponse != null) {
                    System.debug('Data ==>');
                    System.debug(JSON.deserializeUntyped(httpResponse.getBody()));
                }
            }
        } catch (Exception exce) {
            System.debug('Exception occurred while getting the access token from zuora. \n Message ::'
                    + exce.getMessage() + ' \n Cause :: ' + exce.getCause() + ' \n Line Number ::' +
                    exce.getLineNumber() + ' \n Stack Traces ::' + exce.getStackTraceString());
        }
    }
}