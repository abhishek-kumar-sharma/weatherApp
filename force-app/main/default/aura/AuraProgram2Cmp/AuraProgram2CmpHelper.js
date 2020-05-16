({
    fetchAccConOpp : function(component,event,helper) {
              
        try
        {
            var call_Apex_Method = component.get("c.fetchDataAccount");
            console.log('---------> '+call_Apex_Method);
            call_Apex_Method.setCallback(this,function(response)
                                         {
                                             var state = response.getState();
                                             var serverResponse = response.getReturnValue();
                                             if(state == 'SUCCESS')
                                             {
                                                 //alert('In success block') ;
                                                 component.set("v.accConOppData",serverResponse);
                                                 console.log(JSON.stringify(serverResponse));
                                             }
                                             else
                                             {
                                                 alert('Unable to load Account ');
                                             }
                                         });
            $A.enqueueAction(call_Apex_Method);
        }
        catch(ex)
        {
            console.log(ex.message);
        }
    }
})