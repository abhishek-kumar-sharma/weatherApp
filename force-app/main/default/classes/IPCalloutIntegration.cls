/**
 * Created by ABHISHEK on 05-01-2019.
 */

public with sharing class IPCalloutIntegration {
    /**
     * Call out method
     */
    private static String API_KEY ;
    private static String LONG_RUNNING_ENDPOINT_URL;
    private String requestLabel;
    public String result { get; set; }
    public HttpRequest httpRequest;

    @AuraEnabled
    public static void getIPDetails_Without_Param_Apex() {
        /**
         * Getting API credentials and login details
         */
        API_KEY = [select DeveloperName,MasterLabel,NamespacePrefix,ECSV__API_Key_IP_Lookup__c from ECSV__API_Key_IP_Lookup__mdt where DeveloperName = :'IP_Lookup' limit 1].ECSV__API_Key_IP_Lookup__c;
        LONG_RUNNING_ENDPOINT_URL = [select DeveloperName,MasterLabel,NamespacePrefix,ECSV__Endpoint_URL__c,ECSV__Description__c from ECSV__API_Endpoints__mdt where DeveloperName = :'IP_Lookup' limit 1].ECSV__Endpoint_URL__c;
        System.debug('-------------------------------------------------------------------------------------------------------------------------------------------');
        System.debug('API_KEY ===>' + API_KEY);
        if (String.isNotBlank(API_KEY) && String.isNotBlank(LONG_RUNNING_ENDPOINT_URL)) {
            IPCalloutIntegration ipCalloutIntegration = new IPCalloutIntegration();
            System.debug('calling request method ===>');
            ipCalloutIntegration.makeContinuationRequest_Apex();

            /*Http http = new Http();
            System.debug('httpRequest==>'+httpRequest);
            HttpResponse httpResponse = http.send(httpRequest);
            System.debug('===================================================================================================');
            System.debug(httpResponse.getBody());*/
        }
    }

    /**
     *
     * @param inputtedIPLocation Input from user
     */
    @AuraEnabled
    public static void getIPDetails_With_Param_Apex(String inputtedIPLocation) {
        getIPDetails_Without_Param_Apex();
    }


    public void makeContinuationRequest_Apex() {
        /**
         * CONTINUATION TO HOLD THE THINGS WITH CALLBACK METHOD
           */
        /*Continuation continuationObject = new Continuation(5); // timeout max 120
        continuationObject.continuationMethod = 'processContinuationResponse_Apex';*/
        /**
         * SETTING ENDPOINT,REQUEST AND CALLBACK METHOD
         */
        httpRequest = new HttpRequest();
        LONG_RUNNING_ENDPOINT_URL = LONG_RUNNING_ENDPOINT_URL + '?api-key=' + API_KEY;
        httpRequest.setEndpoint(LONG_RUNNING_ENDPOINT_URL);
        httpRequest.setMethod('GET');
        httpRequest.setTimeout(12000);
        System.debug('request ============>' +httpRequest);
        Http http = new Http();
        System.debug('httpRequest==>'+httpRequest);
        HttpResponse httpResponse = http.send(httpRequest);
        System.debug('===================================================================================================');
        System.debug(httpResponse.getBody());
        /*this.requestLabel = continuationObject.addHttpRequest(httpRequest);
        continuationObject.state = 'state var';
        System.debug('continuation object ==>' + continuationObject);
        System.debug('requestLabel object ==>' + requestLabel);
        System.debug('Continuation.getResponse(this.requestLabel) ===>'+Continuation.getResponse(this.requestLabel));
        return continuationObject;*/
    }

    /**
    * Callback method for continuation class
    * will hold the response and error
    */
    public Object processContinuationResponse_Apex() {
        System.debug('================= processContinuationResponse_Apex awake ===============');
        HttpResponse httpResponse = Continuation.getResponse(this.requestLabel);
        /**
         * Replacing 'currency' and wrapping des form
         */
        System.debug('callback method ==>' + httpResponse.getBody());
        /*this.result = httpResponse.getBody();
        System.debug((IPCallout_Deserialization)JSON.deserialize(httpResponse.getBody().replace(''currency':',''currency_Data':'),IPCallout_Deserialization.class));
        return (IPCallout_Deserialization)JSON.deserialize(httpResponse.getBody().replace(''currency':',''currency_Data':'),IPCallout_Deserialization.class);
        */
        String str = '{"ip" : "122.176.115.23"}';
        return (IPCallout_Deserialization)JSON.deserialize(str,IPCallout_Deserialization.class);
    }

}