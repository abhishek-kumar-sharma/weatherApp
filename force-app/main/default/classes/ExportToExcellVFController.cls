/*
 * Created by abhishek on 21/4/18.
 */
public class ExportToExcellVFController {

	Public class WrapperForData{
		public String Label{set;get;}
		public String APIName{set;get;}
		public String dataType{set;get;}
	}

	public static List<WrapperForData> wrapperList{get;set;}

	public ExportToExcellVFController()
		{
			String objectName = ApexPages.currentPage().getParameters().get('objectName');
			System.debug('Object Name received in vf page ---> ' + objectName);
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
								wrapperList.add(wrapperInstance);

							}
						}
				}
				catch (Exception de)
				{
					System.debug('Exception occurred in Apex --> Cause --> ' + de.getCause() + ' Message --> ' +
							de.getMessage());
				}

			} else
			{
				System.debug('Wrong object Name ---> ' + objectName);
			}

		}
}