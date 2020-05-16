({
    loadAccHelper : function(component,event,helper)
    {
        var call_Apex = component.get("c.accAllData");
        call_Apex.setCallback(this,function(response){
            try
            {
                var state = response.getState();
                if(state === 'SUCCESS')
                {
                    var serverResponse = response.getReturnValue();
                  //  console.log(JSON.stringify(serverResponse));
                    component.set("v.tableData",serverResponse);
                    
                }
                else
                {
                    console.log('State -----> '+state);
                }
            }
            catch(ex)
            {
                console.log('catch block in helper ---> '+ex.message);
            }
        });
        $A.enqueueAction(call_Apex);
    }
})