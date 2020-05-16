public with sharing class TestQues19ProTrigger {
	public static void stopOpportunity(List<Opportunity> opportunityList)
  {  
      List<Opportunity> opportunityListUpdated= new List<Opportunity>();
      Set<Id> AccountIdSet=new Set<Id>();
      Set<Id> AccountIdSetUpdated=new Set<Id>();
      List<Account> accountList=new  List<Account>();
      List<Account> accountListUpdated=new  List<Account>();
      map<id,integer> mapAccount=new  map<id,integer>();
      
      for(Opportunity op:opportunityList)
      {
          if(op.StageName=='Closed Won')
          {
              AccountIdSet.add(op.AccountId);
          }
         
      }
      accountList=[select Id from Account where Working_in__c includes('Asia') and Id in :AccountIdSet];
      
      for(Account ac:accountList)
      {
          AccountIdSetUpdated.add(ac.Id);
      }
      
      opportunityListUpdated=[select Id,AccountId,StageName from opportunity where accountId in :AccountIdSetUpdated];
      
           for(Opportunity op:opportunityListUpdated)
        {
          if(op.StageName=='Closed Won')
          {
              if(!mapAccount.containsKey(op.AccountId))
              {
                mapAccount.put(op.AccountId,1);
              }
              else
              {
                   mapAccount.put(op.AccountId,mapAccount.get(op.AccountId)+1);
              }
          }
      }
      
       for(Opportunity op:opportunityList)
      {
          if(op.StageName=='Closed Won')
          {
              if(!mapAccount.containsKey(op.AccountId))
              {
                mapAccount.put(op.AccountId,1);
              }
              else
              {
                   mapAccount.put(op.AccountId,mapAccount.get(op.AccountId)+1);
              }
              
              if(mapAccount.get(op.AccountId)>2)
              {
                  op.addError(' Already 2 Closed Won Opportunity under same Account');
              }
           
          }
         
      }
      
  }
    
}