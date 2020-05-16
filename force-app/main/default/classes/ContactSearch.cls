public  class ContactSearch {
	
	
	     public static List<Contact> searchForContacts(String a,String b){

    List<Contact> cont = [Select Id,Name FROM Contact Where LastName =: a AND MailingPostalCode =: b ];

        return cont;

    }


}