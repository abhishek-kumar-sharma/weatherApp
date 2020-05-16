public with sharing class DataInsert {
	public static void dataInsert()
	{
		/*Creating list for data */
		List<Patient__c> patientList = new List<Patient__c>();   
		List<Doctor__c> doctorList = new List<Doctor__c>();
		
		
		/*Insert data into Patient */
		for(Integer loop_var1 = 0 ; loop_var1 < 20 ; loop_var1++)
		{
			     Patient__c patientObj = new Patient__c();
			     patientObj.Name = 'Patient  '+loop_var1;
			     patientObj.Age__c = 10 + loop_var1;
			     if(Math.mod(loop_var1,2) == 0 )
			     {
			     	patientObj.Gender__c = 'Male';
			     }
			     else 
			     {
			     	patientObj.Gender__c = 'Female';
			     }
			     patientList.add(patientObj);
		}
		
		/*Null check patient list and inserting the List of patient*/ 
		if(patientList.size() > 0)
		{
			try
			{
				insert patientList;
				System.debug('Inserted Paitient List ------> '+patientList);
			}
			catch(DmlException de)
			{
				System.debug('-------------->DML Exception Occoured while Inserting Patient<------------------');
			}
		}
		
		
		/*Insert data into Doctor*/
		for(Integer loop_var2 = 0;loop_var2 < 20 ;loop_var2++ )
		{
			Doctor__c doctorObj = new Doctor__c();
			doctorObj.Name = 'Doctor ' + loop_var2;
			doctorObj.Specialist__c = 'Neurologist';
			doctorList.add(doctorObj);
		}  
		
		/*Null check Doctor List and inserting the doctor list */
		if(doctorList.size() > 0)
		{
			try
			{
				insert doctorList;
				System.debug('Inserted Doctor List ------> '+doctorList);	
			}
			catch(DmlException de)
			{
				System.debug('--------------------> Dml Exception Occurred while inserting the doctor <-------------------');
			}
		}
		
		/*Inserting the Appointment Record 
		List<Appointment__c> appointmentList = new List<Appointment__c>();
		for(Integer loop_var3 = 0 ;loop_var3 < 20 ;loop_var3++)
		{
			Appointment__c appointmentObj = new Appointment__c();
			
		}*/
		
	}
    
}