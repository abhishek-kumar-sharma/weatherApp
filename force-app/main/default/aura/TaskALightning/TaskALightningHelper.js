({
    createContact : function(component,event,helper) 
    { 
        //for testing values
        var conData = component.get("v.newContact");
        console.log('inside helper ---------> ');
        console.log(JSON.stringify(conData));
        
        //calling apex class method saveContact
        try
        {
            var action  = component.get("c.saveContact");
            action.setParams({"con":conData});
            
            action.setCallback(this,function(response)
                               {
                                   var state = response.getState();
                                   if(state == 'SUCCESS')
                                   {
                                       console.log('State successfull---------------> ');  
                                       alert('Contact Saved');
                                       var object= {'sobjectType' : 'Contact'};
                                       component.set("v.newContact",object);
                                   }
                               });
            $A.enqueueAction(action);
        }
        catch(ex)
        {
            console.log(ex);
        }
        
        
        
        
    }
})