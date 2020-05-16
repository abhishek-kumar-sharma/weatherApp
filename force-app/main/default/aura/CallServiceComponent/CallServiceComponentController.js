/**
 * Created by ABHISHEK on 04-05-2019.
 */
({
    injectServiceComponent : function (c,e,h) {
        try {
            let componentName = "c:ServiceComponentCmp";
            $A.createComponent(
                componentName,//component name
                {
                    "aura:id": "serviceCmp", //parameter to pass
                },
                function (newComp, status, errorMessage) {
                    if (status === "SUCCESS") {
                        /*var body = c.get("v.recordSave_Opportunity");
                        body.push(newComp);*/
                        console.log('created');
                        c.set("v.showSelectedComponent", newComp);
                    }
                    else if (status === "INCOMPLETE") {
                        //console.log("No response from server or client is off line.")
                        // Show off-line error
                    }
                    else if (status === "ERROR") {
                        console.log("Error: " + errorMessage);
                        // Show error message
                    }
                }
            );
        }
    catch (ex) {
            console.log(ex);
        }
    }
})