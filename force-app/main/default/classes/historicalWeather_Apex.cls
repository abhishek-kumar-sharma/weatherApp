/**
 * Apex class to serve as a controller to historical weather component
 * Created By : Abhishek Kumar Sharma
 * Created Date : 16 May 2020
 */
public with sharing class historicalWeather_Apex {
    
    /**
     * Method to handle the calling and parsing the API response result for historical data
     * Created By : Abhishek Kumar Sharma
     * Created date : 16 May 2020
     * @param city user inputted city
     * @param startDate user inputted start date Epoch format
     * @param endDate user inputted end date Epoch format
     */
    @AuraEnabled
    public static historicalWeatherAPIWrapper getHistoricalDataViaCityName_Apex(String city, String startDate, String endDate){
        try{
           //https://samples.openweathermap.org/data/2.5/history/city?id=London,UK&type=hour&appid=b1b15e88fa797225412429c1c50c122a1

           if (String.isNotBlank(city) && String.isNotBlank(startDate)  && String.isNotBlank(endDate)) {
               //TODO: '&start='+startDate+'&end='+endDate+ need to add in url once live api available
               // Getting the endpoint and access key from custom setting  
               String url = ECSV__OpenWeatherAPI__c.getValues('OpenWeatherRecord1').ECSV__API_EndPoint__c + city +'&type='+ECSV__OpenWeatherAPI__c.getValues('OpenWeatherRecord1').ECSV__Type__c+'&appid='+ECSV__OpenWeatherAPI__c.getValues('OpenWeatherRecord1').ECSV__API_Key__c;

               // Creating http object and hitting the api 
               Http http = new Http();
               HttpRequest httpRequest = new HttpRequest();
               httpRequest.setEndpoint(url);
               httpRequest.setMethod('GET');
               HttpResponse httpResponse = http.send(httpRequest);
               if (httpResponse.getStatusCode() == 200) {
                   System.debug('response ::'+httpResponse.getBody());
                   historicalWeatherAPIWrapper historicalWeatherAPIWrapperObject = new historicalWeatherAPIWrapper(); 
                   historicalWeatherAPIWrapperObject = (historicalWeatherAPIWrapper)JSON.deserialize(httpResponse.getBody().replaceAll('list', 'list_New'), historicalWeatherAPIWrapper.class);
                   System.debug('historicalWeatherAPIWrapperObject ===>'+historicalWeatherAPIWrapperObject);
                   return historicalWeatherAPIWrapperObject;
               }
           }else{
               return null;
           }
            return null;
        }catch(Exception exce){
            System.debug('Exception occurred while handling the call out via city name in getHistoricalDataViaCityName_Apex method. \n Message ::'+exce.getMessage()+' \n line Number ::'+exce.getLineNumber()+' \n Cause ::'+exce.getCause());
            return null;
        }
    }
}
