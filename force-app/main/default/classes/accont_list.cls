public class accont_list {
    
    public accont_list() {
        loadData();
    }
    
    public list<Account> accList{get;set;}
    public list<Account> deals {get;set;}
    public String dealId {get;set;}
    
    public void loadData(){
        accList=[Select ID, Name, Phone,AccountNumber from Account limit 100];
    }
    
    public void deleteDeal(){
        deals = [Select id,Name from Account where id = :dealId];
        if(deals.size() > 0 || deals[0].Id != ''){
            delete deals;
        }
        loadData();
        
    }
}