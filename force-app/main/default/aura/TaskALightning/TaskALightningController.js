({
    registrationHandler : function(component, event, helper) 
    {
        
        var result = confirm('Are you Sure');
        if(result == true)
        {
            console.log(' In side controller--------------> calling helper method createContact');
            helper.createContact(component,event,helper);
        }
        else
        {
            console.log('operation cancel in controller-----------> ');
        }
    },
})






/* for validation  
    * validatePostCode : function(component, event,helper)
    {
        var postCode = component.find("postalCode");
        var value = postCode.get("v.value");
        if (isNaN(value))
        {
            postCode.set("v.errors", [{message:"Input not a number: " + value}]);
        } 
       else if (value.length() < 6)
        {
            postCode.set("v.errors", null);
        }
    },*/