/**
* Created by abhishek on 16/3/18.
*/

global class WeatherAPIControllerWrapper {
    @AuraEnabled public cls_coord coord;
    @AuraEnabled public cls_weather[] weather;
    @AuraEnabled public String base;    //stations
    @AuraEnabled public cls_main main;
    @AuraEnabled public Integer visibility;    //2800
    @AuraEnabled public cls_wind wind;
    @AuraEnabled public cls_clouds clouds;
    @AuraEnabled public Integer dt;    //1518847200
    @AuraEnabled public cls_sys sys;
    @AuraEnabled public Integer id;    //1273294
    @AuraEnabled public String name;    //Delhi
    @AuraEnabled public Integer cod;    //200
    class cls_coord {
        @AuraEnabled public Double lon;    //77.22
        @AuraEnabled public Double lat;    //28.65
    }
    class cls_weather {
        @AuraEnabled public Integer id;    //721
        @AuraEnabled public String main;    //Haze
        @AuraEnabled public String description;    //haze
        @AuraEnabled public String icon;    //50d
    }
    class cls_main {
        @AuraEnabled public Double temp;    //294.15
        @AuraEnabled public Decimal pressure;    //1014
        @AuraEnabled public Integer humidity;    //56
        @AuraEnabled public Double temp_min;    //294.15
        @AuraEnabled public Double temp_max;//294.15
        @AuraEnabled public Double sea_level;
        @AuraEnabled public Decimal grnd_level;
    }
    class cls_wind {
        @AuraEnabled public Double speed;    //5.1
        @AuraEnabled public Decimal deg;    //300
    }
    class cls_clouds {
        @AuraEnabled public Integer all;    //0
    }
    class cls_sys {
        //        @AuraEnabled public Integer type;    //1
        //        @AuraEnabled public Integer id;    //7809
        @AuraEnabled public Double message;    //0.008
        @AuraEnabled public String country;    //IN
        @AuraEnabled public Integer sunrise;    //1518830867
        @AuraEnabled public Integer sunset;    //1518871369

    }
}