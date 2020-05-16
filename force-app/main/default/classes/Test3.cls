/*class to create 10 event with picklist value*/
public with sharing class Test3 {
	public static void insertData()
	{
		/*creating contact*/
		List<Contact> conList =new List<Contact>();
		for(Integer i=0 ;i<10;i++)
		{
			Contact conObj = new Contact();
			conObj.LastName = 'Abhi '+i+'test3';
			conList.add(conObj);
		}
		insert conList;
		System.debug('----------> Contact list '+conList);
		
		/*creating event*/
		Event_Custom__c eventObj = new Event_Custom__c();
		eventObj.Name ='Script Event';
		eventObj.Event_date__c = System.now();
		insert eventObj;   
		System.debug('---------> Event custom --> '+eventObj);
		
		/*creating event participant*/
		List<Event_Participant__c> eventParList = new List<Event_Participant__c>();
		for(Integer i=0;i<10;i++)
		{
			Event_Participant__c evObj =new Event_Participant__c();
			evObj.Name = 'test 3';
			evObj.Contact__c = conList[i].id;
			evObj.Event_Custom__c = eventObj.id;
			if(i<2)
			{
				evObj.Attendee__c = 'Organizer Contact';
			}
			else if(i<6 && i>2)
			{
				evObj.Attendee__c = 'Presenter Contact';
			}
			else
			{
				evObj.Attendee__c = 'Attendee Contact';
			}
			eventParList.add(evObj);
			
		}
		insert eventParList;
		   System.debug('------------------> event participant list '+eventParList);
	}
    
}