public with sharing class getHistoricalData {
    public String currentRecordId {get;set;}
    public List<ECSV__Additional_Weather_History_Data__c> addWeatherData{get;set;}
    public getHistoricalData() {
        currentRecordId = ApexPages.currentPage().getParameters().get('id');
        addWeatherData = [SELECT ECSV__Clouds__c,ECSV__Date__c,ECSV__Humidity__c,ECSV__Pressure__c,ECSV__Sea_Level__c,ECSV__Temp__c,ECSV__Temp_max__c,ECSV__Temp_min__c,ECSV__Weather__c,ECSV__Wind_Speed__c,ECSV__Weather_History__c FROM ECSV__Additional_Weather_History_Data__c where ECSV__Weather_History__c =:currentRecordId  limit 10000];
    }
}
