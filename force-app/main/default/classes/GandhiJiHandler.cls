public with sharing class GandhiJiHandler {
    public static void manageChasma(List<OpportunityLineItem> newOliList)
    {
        if(newOliList.size() > 0 )
        {
            
            System.debug('dam gandhi ----------> '+newOliList);
            /*Fetching the total available product*/
            Product2 proObj =new Product2();
            proObj = [select Id,Total_Product_available__c from Product2 where Name ='Gandhiji Chasma' ];
            System.debug('Toatal chasma available ------>'+proObj.Total_Product_available__c);
            
            /*Fetching all the opportunity line item having gandhi ji chasma */
            List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
            oliList = [select Name,OpportunityId,Product2Id,Quantity,TotalPrice from OpportunityLineItem where Product2Id =: proObj.Id ];
            System.debug('oli list=-------=>' +oliList); 
            
            /*Calculating the total quantity sold */
            Decimal total_Quantity_sold = 0 ;
            for(OpportunityLineItem oliTemp : oliList)
            {
                total_Quantity_sold += oliTemp.Quantity;
            }
            
            System.debug('total quantity sold -------------> '+total_Quantity_sold);
            
            /*Comparing the total and new quantity*/
            for(OpportunityLineItem oliTemp : newOliList)
            {
                if(proObj.Total_Product_available__c < (total_Quantity_sold + oliTemp.Quantity))
                {
                        oliTemp.addError('Available product must be greater than total sold');
                
                }
            }
            
            
            
        }  
        else
        {
            System.debug('---------NULL OLI LIST RECIEVED------');
        }
    }
    
}