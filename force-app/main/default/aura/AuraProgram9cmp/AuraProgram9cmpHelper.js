({
    createContactHelper : function(component,event,helper)
    {
        console.log('Recieved data --> '+JSON.stringify(component.get("v.newContact")));
        /*var data = component.find("lookupField").get("v.value");
        console.log('data '+data);
        var data1 = component.find("lookupField").get("v.searchField");
        console.log('data1 '+data1);
        console.log("lookup data -->"+data);*/
        var conUIData = component.get("v.newContact");
        
        var call_Apex = component.get("c.createContact_Apex");
        call_Apex.setParams({"con":conUIData});
        call_Apex.setCallback(this,function(response){
            
            try
            {
                var state = response.getState();
                if(state === 'SUCCESS')
                {
                    console.log('contact created');
                    component.set("v.showModal",true);
                }
                else
                {
                    console.log('State --> '+state);
                }
                
            }
            catch(ex)
            {
                console.log('Catch Block --> '+ex.message);
            }
        });
        $A.enqueueAction(call_Apex);
        
    },
   /* //method to load account
    loadAccountHelper : function(component,event,helper)
    {
        var call_Apex = component.get("c.loadAccount_Apex");
        
        call_Apex.setCallback(this,function(response){
            
            try
            {
                var state = response.getState();
                if(state === 'SUCCESS')
                {
                    var serverResponse = response.getReturnValue();
                    //console.log('Server Response value ---> '+JSON.stringify(serverResponse));
                    
                    //formatting value for combobox
                    var options = [];
                    for(var i=0 ; i<serverResponse.length;i++)
                    {
                        var temp = {value:serverResponse[i].Id,label:serverResponse[i].Name};
                       // console.log('In loop temp value --> '+JSON.stringify(temp));
                        options.push(temp);
                    }
                    console.log('options --> '+JSON.stringify(options));
                    component.set("v.accOption",options);
                }
                else
                {
                    
                }
            }
            catch(ex)
            {
                console.log('Catch Block --> '+ex.message);
            }
        });
        $A.enqueueAction(call_Apex);
}*/

})