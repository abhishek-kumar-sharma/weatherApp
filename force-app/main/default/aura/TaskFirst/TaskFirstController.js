({
    /* Method to handle delete button */

    deleteController : function (component,event,helper) {
        helper.deleteHelper(component,event,helper);
    },
    handleModal : function (component,event,helper) {
        component.set("v.showModal",false);
    }


})