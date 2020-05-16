public class Program19 {
     public void userAdd(){
            UserRole adminUser=new UserRole(Name= 'Abhishek new'); 
            insert adminUser; 
            Profile prof= [Select Id from profile where Name='System Administrator']; 
     
   User newUser=new User(firstname = 'Trinity', lastName = 'Neo', email = 'trinity@matrix.com',Username = 'neo@matrix.com',EmailEncodingKey = 'ISO-8859-1',Alias = 'trinity',TimeZoneSidKey = 'America/Los_Angeles',LocaleSidKey = 'en_US',LanguageLocaleKey = 'en_US',ProfileId = prof.Id,UserRoleId = adminUser.Id); 
    
 insert newUser;
System.debug(newUser);
     }
}