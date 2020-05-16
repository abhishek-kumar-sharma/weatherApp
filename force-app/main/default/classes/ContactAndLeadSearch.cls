public with sharing class ContactAndLeadSearch {
	public static List<List<SObject>> searchContactsAndLeads(String parma)
	{
		List<List<sObject>> searchList = [FIND :parma IN ALL FIELDS 
                   RETURNING Lead(Name),Contact(FirstName,LastName)];
                   return searchList;
	}
    
}