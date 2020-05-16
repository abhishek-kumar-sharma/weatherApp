({
	updateButtonHandler : function(component, event, helper)
    {
		helper.updateButtonHelper(component,event,helper);
		
	},
    cancelButtonHandler : function(component,event,helper)
    {
        var id = component.get('v.pageId');
        window.close("/"+id);
       // location.replace("/"+id)
    }
})