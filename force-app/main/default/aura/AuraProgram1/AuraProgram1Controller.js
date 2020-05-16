//AuraProgram1Controller
({
    clickControllerAccount : function(component, event, helper) {
        //alert('Controller called ');
        var name = component.find("Name").get("v.value");

        console.log('Name value --> '+name);
        if(name !== undefined && name !== null ) {
            helper.createAccount(component, event, helper);
        }
        else
        {
            var name = component.find("Name");
            $A.util.addClass(name, 'slds-has-error');
           // name.focus();

        }
    },
    setFocus : function (component,event,helper) {
        console.log('App Hosted');
        var name = component.find("Name");
        name.focus();
        //component.find("Name").getElement().focus();
    }
})