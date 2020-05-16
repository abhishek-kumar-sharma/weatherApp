({
    doInit : function(component, event, helper) {
        alert('Initilized in controller');
        //Calling helper
        helper.doInitHelper(component,event,helper);
    },
    AreInit : function(component,event,helper)
    {
    alert('reInit in controller');
},
    updateOnValue:function(c,e,h)
    {
        var NameRec = c.get("v.nameTest");
        c.set("v.nameTest","Abhishek")
    }
 
 })