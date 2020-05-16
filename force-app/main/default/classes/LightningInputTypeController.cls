/*
 * Controller class for : LightningInputTime component
 */
public class LightningInputTypeController {

	/*
	 * Method to upsert the data of check in and check out time
	 */
	@AuraEnabled
	public static ECSV__Hotel__c saveTime_Apex(String objectData)
		{
			try {
				/*
				 * Deserializing the received data to object type
				 */
				Map<String, Object> receivedDataMap = new Map<String, Object>();
				receivedDataMap = (Map<String, Object>) JSON.deserializeUntyped(objectData);
				System.debug('Map Key set -->' + receivedDataMap.keySet());
				System.debug('Value set --->' + receivedDataMap.values());

				/*
				 * Getting the all fields type of Hotel object
				 */
				ECSV__Hotel__c hotelObject = new ECSV__Hotel__c();
				Schema.SObjectType hotelObjectInstance = Schema.getGlobalDescribe().get('ECSV__Hotel__c');
				Schema.DescribeSObjectResult hotelObjectDescribe = hotelObjectInstance.getDescribe();

				/*
				 * Iterating the map value for time and date data type
				 */
				for (String dataInstance : receivedDataMap.keySet()) {
					if (dataInstance != 'sobjectType') {
						/*
						 * Constructing the sobject field type
						 */
						Schema.DescribeFieldResult hotelField =
								hotelObjectDescribe.fields.getMap().get(dataInstance).getDescribe();
						/*
						 * Manipulating the time and date type
						 */
						if (hotelField.getType() == Schema.DisplayType.Time) {
							String timeInString = String.valueOf(receivedDataMap.get(dataInstance));
							Time codedTimeWithTimeZone = Time.newInstance(Integer.valueOf(timeInString.subString(0, 2)),
									Integer.valueOf(timeInString.subString(3, 5)),
									Integer.valueOf(timeInString.subString(6, 8)),
									Integer.valueOf(timeInString.subString(11)));
							hotelObject.put(dataInstance, codedTimeWithTimeZone);

						} else if (hotelField.getType() == Schema.DisplayType.Date) {
							//date conversion
							String dateString = String.valueOf(receivedDataMap.get(dataInstance));
							Date convertedDate =
									Date.newInstance(Integer.valueOf(dateString.substring(0, 4)),
											Integer.valueOf(dateString.substring(5, 7)),
											Integer.valueOf(dateString.substring(8, 10)));
							hotelObject.put(dataInstance, convertedDate);

						} else {
							System.debug('else');
							hotelObject.put(dataInstance, receivedDataMap.get(dataInstance));
						}
					}
				}
				System.debug('hotel object after modification ---> ' + hotelObject);
				upsert hotelObject;
				return hotelObject;
			} catch (Exception exceptionInstance) {
				System.debug('exceptionInstance.getMessage() ---> ' + exceptionInstance.getMessage());
				throw new AuraHandledException(exceptionInstance.getMessage());
			}

		}

}