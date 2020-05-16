/*Apex class to fetch the record from teacher and student */

public with sharing class FetchData {
	public static void fetchData()
	{
		
		
		List<Teacher__c> teacherList = new List<Teacher__c>();
		List<Student__c> studentList = new List<Student__c>();
		//Fetching the details of teacher and student	
		teacherList = [select Name,Subject__c from teacher__c where Subject__c !=NULL];
		studentList = [select Name,Subjects__c,Teacher__r.Name from Student__c where Teacher__c !=NULL];  
		
		//Printing teacher Records
		for(Teacher__c teachTemp : teacherList)
		{
			System.debug('-------------->'+teachTemp.Name);
			System.debug('-------------->'+teachTemp.Subject__c);
		} 
		//Printing Student Records
		for(Student__c studTemp : studentList)
		{
			System.debug('-------------->'+studTemp.Name);   
			System.debug('-------------->'+studTemp.Subjects__c);
			System.debug('-------------->'+studTemp.Teacher__r.Name);
		}
		
		/*Assigning the teacher via teacher subject to student who have no teacher assigned
		List<Student__c> studentListTemp = new List<Student__c>();
		studentListTemp = [select Name,Teacher__c from Student__c where Teacher__c !=null];
		//System.debug('-----> '+studentListTemp);
		Set<Id> teachAssignIdSet = new Set<Id>();
		
		for(Student__c stud : studentListTemp)
		{
		    teachAssignIdSet.add(stud.Teacher__c);
		}
		system.debug('Teacher Id Set ---------> '+teachAssignIdSet);
		List<Teacher__c> notAssignedTeacherList = new List<Teacher__c>();
		notAssignedTeacherList = [select Name,Subject__c from Teacher__c where Id NOT IN: teachAssignIdSet];
		System.debug('Not assigned teachers name :');
		System.debug('Teachers     ---    Subject   ');
		for(Teacher__c notAssign : notAssignedTeacherList)
		{
		system.debug(notAssign.Name +' --- ' +notAssign.Subject__c);
		}
		
		List<Student__c> notAssignStudentList = new List<Student__c>();
		notAssignStudentList = [Select Name,Subjects__c,Teacher__c from Student__c where Teacher__c = NULL];
		System.debug('Not Assigned Student ');
		system.debug('Student   ---   Subjects');
		for(Student__c stud : notAssignStudentList)
		{
			System.debug(stud.Name+'   ---   '+stud.Subjects__c);
		}
		
		List<Student__c> newUpdateListStud = new List<Student__c>();
		for(Teacher__c teachObj : notAssignedTeacherList)
		{
			for(Student__c studObj : notAssignStudentList)
			{
				if(studObj.Subjects__c.Contains(teachObj.Subject__c) && studObj.Teacher__c == null)
				{
					studObj.Teacher__c = teachObj.Id;
					newUpdateListStud.add(studObj);
				}
			}
		}
		
		insert newUpdateListStud;
		System.debug('New Upadte ------------>'+newUpdateListStud);
		/*System.debug('teacher ----> '+notAssignedTeacherList);
		System.debug('Student ----> '+notAssignStudentList);*/
	
	}
    
}