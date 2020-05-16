({
    loadOppData : function(component,event,helper)
    {
        var colOptions = [];
        
        var temp = {label:'Opportuniy Id',fieldName:'Id',sortable:true, initialWidth: '20px'};
        colOptions.push(temp);
        temp = {label:'Opportuniy Name',fieldName:'Name',sortable:true};
        colOptions.push(temp);
        temp = {label:'Stage Name',fieldName:'StageName',sortable:true};
        colOptions.push(temp);
        temp = {label:'Close Date',fieldName:'CloseDate',sortable:true};
        colOptions.push(temp);
        
        //console.log('column --> '+JSON.stringify(colOptions));
        component.set("v.oppColumns",colOptions);
        
        var call_Apex = component.get("c.getAllOpportunity");
        call_Apex.setCallback(this,function(response){
            try
            {
                var state = response.getState();
                if(state === 'SUCCESS')
                {
                    var serverResponse = response.getReturnValue();
                    //console.log('server response --> '+JSON.stringify(serverResponse));
                    component.set("v.oppOptions",serverResponse);
                }
                else
                {
                    Console.log('State --> '+state);
                }
            }
            catch(ex)
            {
                console.log('Catch Block --> '+ex.message);
            }
        });
        $A.enqueueAction(call_Apex);
    }
})