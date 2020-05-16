/*
 * Created by abhishek on 16/3/18.
 */

public with sharing class WeatherAPIController {


    /*
	 * Method to check account city if available at load time of component
	 */
    @AuraEnabled
    public static String getCityAddress_Apex(String recordId)
        {
           System.debug('record id ------> '+recordId);
            if(recordId != null)
            {
                List<Account> accountList = new List<Account>();
                accountList = [select Id,BillingCity,ShippingCity from Account where Id =: recordId limit 1];
                System.debug('Account list --------->>>> '+accountList);
                if(accountList.size() > 0)
                {
                    for (Account accountInstance : accountList)
                        {
                            if (accountInstance.BillingCity != null)
                            {
                                return accountInstance.BillingCity;
                            }
                            if (accountInstance.ShippingCity != null)
                            {
                                return accountInstance.ShippingCity;
                            }
                            if(accountInstance.BillingCity != null && accountInstance.ShippingCity != null )
                            {
                                return accountInstance.BillingCity;
                            }
                        }
                }

            }
            else
            {
                System.debug('Null Account Id recieved ----> '+recordId);
            }
            return null;

        }


    /*
	 * Method to get weather api data open weather api integration
	 */
    @AuraEnabled
    public static WeatherAPIControllerWrapper getData_Apex(String city) {

        WeatherAPIControllerWrapper classInstance = new WeatherAPIControllerWrapper();

        System.debug('Received Data  city ---> ' + city);
        if (city != null) {
            if (city.containsWhitespace()) {
                System.debug('city------' + city);
                city = city.trim();
                city = city.replaceAll('(\\s+)', '%20');
                System.debug('city------' + city);
            }

            Http http = new Http();

            /*
			    * Request section
			    */
            HttpRequest httpRequest = new HttpRequest();
            String endPoint = 'http://api.openweathermap.org/data/2.5/weather?q=' + city +'&APPID=dbbb9ef3bc1d3f8da897d05693851e42&units=Imperial';
            System.debug('endPoint--------->' + endPoint);
            httpRequest.setEndpoint(endPoint);
            httpRequest.setMethod('GET');

            /*
			    * Response section
			    */
            HttpResponse httpResponse = http.send(httpRequest);
            if (httpResponse.getStatusCode() == 200) {
                System.debug('Result from whether api  -----> ' + httpResponse.getBody());
                /* Filling the main wrapper */
                classInstance = (WeatherAPIControllerWrapper) JSON.deserialize(httpResponse.getBody(), WeatherAPIControllerWrapper.class);

                System.debug('Result from whether api  -----> ' + classInstance);


                return classInstance;
            }
            return null;


        } else {
            System.debug('Null data received  city ---> ' + city);
            return null;
        }

    }


    /* Method to predict city name on basic of input google place api integration  */
    @AuraEnabled
    public static void predictCities_Apex(String cityNameString)
        {
            System.debug('got it '+cityNameString);
            //https://maps.googleapis.com/maps/api/place/autocomplete/json?input=moha&key=AIzaSyAdtqrEIIIFwq62GfuBEeMR2mLU2cbs8sY
            Http http = new Http();
            HttpResponse httpResponse = new HttpResponse();
            HttpRequest httpRequest = new HttpRequest();

            httpRequest.setEndpoint('https://maps.googleapis.com/maps/api/place/autocomplete/json?input='+cityNameString+'&key=AIzaSyAdtqrEIIIFwq62GfuBEeMR2mLU2cbs8sY');
            httpRequest.setMethod('GET');
            httpResponse = http.send(httpRequest);
            System.debug('Response code ' +httpResponse.getBody());
        }

}