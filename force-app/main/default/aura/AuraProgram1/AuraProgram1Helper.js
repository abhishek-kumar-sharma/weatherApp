({
	createAccount : function(component,event,helper) {
        //alert('Helper called ');

        var accData = component.get("{!v.newAccount}");
       // console.log('successfull ----> ');
        console.log(JSON.stringify(accData));

        try
        {
            var action  = component.get("c.createAccountHandler");
            action.setParams({"acc":accData});

            action.setCallback(this,function(response)
                               {
                                   var state = response.getState();
                                   if(state == 'SUCCESS')
                                   {
                                       console.log('State successfull---------------> ');
                                       alert('Account Saved');
                                       var object= {'sobjectType' : 'Account'};
                                       component.set("v.newAccount",object);

                                       // toast test
                                       var resultToast  =$A.get("e.force:showToast");
                                       resultToast.setParams({
                                           "title":"Account",
                                           "message":"Account Created Successfully"
                                       });
                                       resultToast.fire();

                                       var dismissActionPanel = $A.get("e.force:closeQuickAction");
                                       dismissActionPanel.fire();


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