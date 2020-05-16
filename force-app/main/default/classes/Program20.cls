public  class Program20 {
    
    public static void user()
        
    {
        UserRole adminUser=new UserRole(Name='Developer'); 
        insert adminUser; 
        Profile prof= [Select Id from profile where Name='System Administrator']; 
        User newUser=new User(firstname = 'neo', lastName = 'trinity', email = 'neo@matrix.com',Username = 'ne@rix.com',
                              EmailEncodingKey = 'ISO-8859-1', 
                              Alias = 'trinity', 
                              TimeZoneSidKey = 'America/Los_Angeles', 
                              LocaleSidKey = 'en_US', 
                              LanguageLocaleKey = 'en_US', 
                              ProfileId = prof.Id, 
                              UserRoleId = adminUser.Id); 
        
        
        insert newUser;
        System.debug(newUser);
        
    }
}