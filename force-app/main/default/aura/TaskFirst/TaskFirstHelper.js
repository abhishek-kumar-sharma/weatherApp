({
    /* Method to handle Delete button controller method -->  'deleteController' */
    deleteHelper : function (component,event,helper) {
        var recordId = component.get("v.recordId");
        var sObjectName = component.get("v.sObjectName");

        console.log('Record Id --> '+recordId+' Object Name --> '+sObjectName);


        if(recordId !== null || recordId !== undefined || recordId !== 'null' || recordId !== 'undefined' || recordId !== '' || sObjectName!== null || sObjectName !== undefined || sObjectName !== 'null' || sObjectName !== 'undefined' || sObjectName !== '' )
        {
            /*Calling apex method to change owner Id*/
            var call_Apex = component.get("c.changeOwnerId_Apex");
            call_Apex.setParams({'recordId':recordId,'sObjectName':sObjectName});

            try
            {
                call_Apex.setCallback(this,function (response) {
                    var state = response.getState();
                    if(state === 'SUCCESS' && component.isValid())
                    {
                        console.log('Owner Id changed state ---> '+state);
                        component.set("v.showModal",true);
                    }
                    else
                    {
                        console.log('Error occurred state --> '+state);

                    }

                });

            }
            catch (ex)
            {
                console.log('Exception Occurred while calling apex '+ex.message);
            }
            $A.enqueueAction(call_Apex);

        }
        else
        {
            console.log('Unable to call apex Record Id ---> '+recordId+'  sobject Name  ---> '+sObjectName);
        }

    }

})