/**
 * Created by abhishek on 9/3/18.
 */

({
    createOppHelper :function (component,event,helper) {
        var data = component.get("v.newOpp");
        console.log('Data ---> '+JSON.stringify(data));

    },

    loadAccountHelper : function (component,event,helper) {
       var key = component.get("v.newOpp.AccountId");

        if(key !== null || key !== 'null' || key !== undefined)
        {
            var call_Apex = component.get("c.getAccountData_Apex");
            call_Apex.setParams({'keyword':key});

            call_Apex.setCallback(this,function (response) {
                try
                {
                    console.log('try block ');
                    var state = response.getState();
                    if(state === 'SUCCESS' && component.isValid())
                    {
                        var sereverResponse = response.getReturnValue();
                        console.log('server response --> '+JSON.stringify(sereverResponse));
                        component.set("v.accountData",sereverResponse);
                        component.set("v.showAccountList",true);
                    }
                    else
                    {
                        console.log('Error occurred ----> '+state);
                    }
                }
                catch (ex)
                {
                    console.log('Exception occurred ---> '+ex.message);
                }

            })

            $A.enqueueAction(call_Apex);
        }


    }
})