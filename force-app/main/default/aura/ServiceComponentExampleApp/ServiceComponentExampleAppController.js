/**
 * Created by ABHISHEK on 04-05-2019.
 */
({
    /**
     * Method to inject service component caller
     * @param c
     * @param e
     * @param h
     */
    injectComponent : function (c,e,h) {
        let componentName = "c:CallServiceComponent";
        $A.createComponents(componentName,{
                "aura:id": "callServiceCmp", //parameter to pass
            },
            function(components, status, errorMessage){
                if (status === "SUCCESS") {
                    console.log('Component injected app');
                }
                else if (status === "INCOMPLETE") {
                    console.log("No response from server or client is offline.")
                    // Show offline error
                }
                else if (status === "ERROR") {
                    console.log("Error: " + errorMessage);
                    // Show error message
                }
            }
        );
    }
})