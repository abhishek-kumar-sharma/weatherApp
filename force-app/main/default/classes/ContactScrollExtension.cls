/*program Name VFProgram7*/
public class ContactScrollExtension {
 public List<Contact> conList{get;set;}
    public ContactScrollExtension() {	
        conList = new List <Contact>();
        conList = [select Name,Account.Name,Phone,Fax from Contact limit 20];
     }
}