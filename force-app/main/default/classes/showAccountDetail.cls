public class showAccountDetail {
    
    public String accountId{get;set;}
    public Opportunity acc{get;set;}
   
   
    
    public showAccountDetail(ApexPages.StandardController stdcontroller)
    {
        acc=new Opportunity();
          accountId=stdcontroller.getRecord().id;
        acc=[select id,Name
             From Opportunity ];
        
    }
    
    
}