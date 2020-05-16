({
    createContact : function(component,event,helper)
    {
        helper.createContactHelper(component,event,helper);
    },
    
    closeModel : function(component,event,helper)
    {
        component.set("v.showModal",false);
    },
    /*loadAccount : function(component,event,helper)
    {
        helper.loadAccountHelper(component,event,helper);
    },
    comboBoxChange : function(component,event,helper)
    {
        console.log("Selected Account Id --> "+event.getParam("value"));
    },*/
    
    
})