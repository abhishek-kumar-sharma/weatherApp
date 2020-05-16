public with sharing class FetchAccount {
    
    public List<Account> FetchData{set;get;}
    public List<Account> fetchData()
    {
        List<Account> accList = new List<Account>();
        accList = [select Name,Phone,AnnualRevenue from Account limit 100];
        return accList;
    }
}