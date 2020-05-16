public class historicalWeatherAPIWrapper{
	@AuraEnabled public String message;	//
	@AuraEnabled public String cod;	//200
	@AuraEnabled public Integer city_id;	//2885679
	@AuraEnabled public Double calctime;	//0.0823
	@AuraEnabled public Integer cnt;	//3
	@AuraEnabled public cls_list[] list_New;
	class cls_list {
		@AuraEnabled public cls_main main;
		@AuraEnabled public cls_wind wind;
		@AuraEnabled public cls_clouds clouds;
		@AuraEnabled public cls_weather[] weather;
		@AuraEnabled public Integer dt;	//1485722804
	}
	class cls_main {
		@AuraEnabled public Double temp;	//266.052
		@AuraEnabled public Double temp_min;	//266.052
		@AuraEnabled public Double temp_max;	//266.052
		@AuraEnabled public Double pressure;	//957.86
		@AuraEnabled public Double sea_level;	//1039.34
		@AuraEnabled public Double grnd_level;	//957.86
		@AuraEnabled public Integer humidity;	//90
	}
	class cls_wind {
		@AuraEnabled public Double speed;	//1.16
		@AuraEnabled public Double deg;	//139.502
	}
	class cls_clouds {
		@AuraEnabled public Integer all;	//0
	}
	class cls_weather {
		@AuraEnabled public Integer id;	//800
		@AuraEnabled public String main;	//Clear
		@AuraEnabled public String description;	//Sky is Clear
		@AuraEnabled public String icon;	//01n
	}
	public static historicalWeatherAPIWrapper parse(String json){
		return (historicalWeatherAPIWrapper) System.JSON.deserialize(json, historicalWeatherAPIWrapper.class);
	}

	/*
	static testMethod void testParse() {
		String json=		'{"message":"","cod":"200","city_id":2885679,"calctime":0.0823,"cnt":3,"list_New":[{"main":{"temp":266.052,"temp_min":266.052,"temp_max":266.052,"pressure":957.86,"sea_level":1039.34,"grnd_level":957.86,"humidity":90},"wind":{"speed":1.16,"deg":139.502},"clouds":{"all":0},"weather":[{"id":800,"main":"Clear","description":"Sky is Clear","icon":"01n"}],"dt":1485722804},{"main":{"temp":263.847,"temp_min":263.847,"temp_max":263.847,"pressure":955.78,"sea_level":1037.43,"grnd_level":955.78,"humidity":91},"wind":{"speed":1.49,"deg":159},"clouds":{"all":0},"weather":[{"id":800,"main":"Clear","description":"Sky is Clear","icon":"01n"}],"dt":1485749608},{"main":{"temp":274.9,"pressure":1019,"temp_min":274.15,"temp_max":275.15,"humidity":88},"wind":{"speed":1,"deg":0},"clouds":{"all":76},"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"dt":1485773778}]}';
		historicalWeatherAPIWrapper obj = parse(json);
		System.assert(obj != null);
	}*/
}