({
    getAccountData : function(component,event,helper) {
        try
        {
            var action = component.get("c.getAccountDetails");
            action.setCallback(this,function(response)
                               {
                                   var state = response.getState();
                                   if(state === 'SUCCESS' & component.isValid())
                                   {
                                       var serverResponse = response.getReturnValue();
                                       // alert(JSON.stringify(serverResponse));
                                       component.set("v.mydata",serverResponse);
                                   }
                                   else
                                   {
                                       console.log('unable to  fetch account');
                                       return null;
                                   }
                               });
        }
        catch(ex)
        {
            console.log(ex.message);
        }
        $A.enqueueAction(action);
        
    } ,
    sortDatahelper : function(component,event,helper)
    {
        var data = component.get("v.mydata");
        data.sort();
        console.log(data);
        component.set("v.mydata",data);
        
    },
    apexSort : function(component,event,helper)
    {
        try
        {
            var action = component.get("c.reGetSortData");
            action.setCallback(this,function(response)
                               {
                                   var state = response.getState();
                                   if(state === 'SUCCESS' & component.isValid())
                                   {
                                       var serverResponse = response.getReturnValue();
                                       // alert(JSON.stringify(serverResponse));
                                       component.set("v.mydata",serverResponse);
                                   }
                                   else
                                   {
                                       console.log('unable to  fetch account');
                                       return null;
                                   }
                               });
        }
        catch(ex)
        {
            console.log(ex.message);
        }
        $A.enqueueAction(action);
        
    }
    
})