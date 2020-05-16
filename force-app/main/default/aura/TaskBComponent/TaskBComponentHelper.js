({
    checkLogin : function(component, event, helper) {
        
        var rec_data = component.get("{!v.loginCon}");
        console.log(JSON.stringify(rec_data));
        
        try 
        {
            var call_Apex_Method = component.get("c.fetchContact");
            call_Apex_Method.setParams({"con" : rec_data});
            
            call_Apex_Method.setCallback(this,function(response)
                                         {
                                             var state = response.getState();
                                             if(state == 'SUCCESS')
                                             {
                                                 if(response.getReturnValue()!=null){
                                                     alert('Login Successfull  '+response.getReturnValue().FirstName+' '+response.getReturnValue().LastName);
                                                     
                                                     console.log('Successfull---------------->');
                                                 }
                                                 
                                                 else{
                                                     alert('Wrong Email or Password');
                                                 }
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