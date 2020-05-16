/*
 * Created by abhishek on 19/4/18.
 */
public class ExportToExcellHandler {

	/*
	 * Wrapper to contain all return data (Field Label,Field API Name,Field Data type
	 */
	Public class WrapperForData{
		@AuraEnabled public String Label;
		@AuraEnabled public String APIName;
		@AuraEnabled public String dataType;
	}

	/*
	 * Method to get all field labels,api name,data type
	 */
	@AuraEnabled
	public static List<WrapperForData> loadAllFields(String objectName)
		{
			System.debug('Object Name ---> ' + objectName);
			if (objectName != null)
			{
				try
				{
					for (Schema.SObjectType obj : Schema.getGlobalDescribe().values())
						{
							Schema.DescribeSObjectResult objDescription = obj.getDescribe();
							if (objDescription.getLabel() == objectName) {
								objectName = objDescription.getName();
							}
						}

					List<WrapperForData> wrapperForDataList = new List<WrapperForData>();

					Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
					Schema.SObjectType leadSchema = schemaMap.get(objectName);
					Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();

					for (String str : fieldMap.keySet())
						{
							WrapperForData wrapperInstance = new WrapperForData ();
							if (fieldMap.get(str).getDescribe().isUpdateable()) {
								/* Filling the wrapper */
								Schema.SObjectField field = fieldMap.get(str);
								Schema.DisplayType dataType = field.getDescribe().getType();
								wrapperInstance.APIName = String.valueOf(fieldMap.get(str));
								wrapperInstance.Label = String.valueOf(fieldMap.get(str).getDescribe().getLabel());
								wrapperInstance.dataType = String.valueOf(dataType);
								wrapperForDataList.add(wrapperInstance);

							}
						}

					if (wrapperForDataList.size() > 0)
					{
						return wrapperForDataList;

					} else
					{
						return null;
					}

				} catch (Exception de)
				{
					System.debug('Exception occurred in Apex --> Cause --> ' + de.getCause() + ' Message --> ' +
							de.getMessage());
					return null;
				}
				return null;

			} else
			{
				System.debug('Wrong object Name ---> ' + objectName);
				return null;
			}
		}

}