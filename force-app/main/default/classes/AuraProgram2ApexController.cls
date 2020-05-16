public class AuraProgram2ApexController {
    
    /*Wrapper class*/
    private class AccConOppWrapper
    {
        @AuraEnabled string accName {set;get;}
        @AuraEnabled List<String> wrapConList{set;get;}
        @AuraEnabled List<String> wrapOppList{set;get;}
    }
    
    @AuraEnabled
    public static List<AccConOppWrapper> fetchDataAccount()
    {
        List<AccConOppWrapper> returnListWrap = new List<AccConOppWrapper>();
        List<Account> accList = new List<Account>();
        List<Contact> conList = new List<Contact>();
        List<Opportunity> oppList = new List<Opportunity>();
        
        /*fetching Account */
        accList = [select Id,Name from Account limit 90];
        System.debug('------------------> '+accList);
        if(accList.size() > 0)
        {
            /*creating Account Id set*/
            Set<Id> accIdSet = new Set<Id>();
            for(Account accTemp : accList)
            {
                accIdSet.add(accTemp.Id);
            }
            System.debug('------------> account Id Set----> '+accIdSet);            
            if(accIdSet.size() > 0 )
            {
                /*Fectching contact and opportunity*/
                conList = [select Name,AccountId from Contact where AccountId =: accIdSet];
                oppList = [select Name,AccountId from Opportunity where AccountId =: accIdSet];
                System.debug('Contact List Before Map -----> '+conList);
                System.debug('Opportunity List Before Map ------> '+oppList);
                if(conList.size() < 0)
                {
                    System.debug('Null contact List Recieved');
                    return null;
                }
                if(oppList.size() < 0)
                {
                    System.debug('Null Opportunity List Recieved');
                    return null;
                }
            }
            
            /*Map of AccountID and related contact name*/
            map<Id,List<String>> accIdvsConMap = new map<Id,List<String>>();
            for(Contact conTemp : conList)
            {
                if(!accIdvsConMap.containsKey(conTemp.AccountId))
                {
                    accIdvsConMap.put(conTemp.AccountId,new List<String>());
                }
                accIdvsConMap.get(conTemp.AccountId).add(conTemp.Name);
            }
            System.debug('Account Id and Contact name Map Data--------> '+accIdvsConMap);
            
            /*Map of AccountId and related opportunity Name*/   
            map<Id,List<String>> accIdvsOppMap = new map<Id,List<String>>();
            for(Opportunity oppTemp : oppList)
            {
                if(!accIdvsOppMap.containsKey(oppTemp.AccountId))
                {
                    accIdvsOppMap.put(oppTemp.AccountId,new List<String>());
                }
                accIdvsOppMap.get(oppTemp.AccountId).add(oppTemp.Name);
            }
            System.debug('Account Id and Opportunity name Map Data--------> '+accIdvsOppMap);
            
            for(Account accTemp : accList)
            {
                AccConOppWrapper acconwrapper = new AccConOppWrapper();
                acconwrapper.accName = accTemp.Name;
                acconwrapper.wrapConList = accIdvsConMap.get(accTemp.Id);
                acconwrapper.wrapOppList = accIdvsOppMap.get(accTemp.Id);
                returnListWrap.add(acconwrapper);         
            }
            System.debug('Wrapper data ->>>>>>>>>>>>>--------->>>>>>>>  '+returnListWrap);
            
            //main return 
            return returnListWrap;
        }
        else
        {
            System.debug('Unable to fetch Account Null List recieved');
            return null;
        }
        
        
    }
    
}