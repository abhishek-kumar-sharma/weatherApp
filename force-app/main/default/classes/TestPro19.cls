public with sharing class TestPro19 {
	public static void getTotalQuantity()
   {
       Set<Id> oppIdSet=new Set<Id>();
       Set<Id> AccountIdSet=new Set<Id>();
       map<Id,decimal> mapQuantity=new map<Id,decimal>();
       List<Account> accList=[select id from Account where Working_in__c includes('Asia')];
       for(Account ac:accList)
       {
           AccountIdSet.add(ac.Id);
       }     
       
       List<opportunity> oppList=[select Id,AccountID from opportunity where Stagename='Closed Won' and accountId in:AccountIdSet];
       System.debug('opportunity--------->>>>>>>'+oppList);
       for(opportunity op:oppList)
       {
           oppIdSet.add(op.Id);
       }
       
       List<opportunityLineItem> oliList=[select Opportunityid,product2Id,Quantity from  opportunityLineItem where opportunityId in :oppIdSet];
       System.debug('Opl--------->>>>>>'+oliList);
       for(opportunityLineItem oli:oliList)
       {
          if(! mapQuantity.containsKey(oli.product2Id))
          {
              mapQuantity.put(oli.product2Id,oli.Quantity);
          }
           else
           {
               mapQuantity.put(oli.product2Id,mapQuantity.get(oli.product2Id)+oli.Quantity);
           }
       }
       
       System.debug(''+mapQuantity);
       
   }
    
}