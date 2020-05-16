({
	doInitHelper : function(componenet,event,helper) {
        alert('In Helper method');
        helper.seconHelperMethod();
		
	},
    seconHelperMethod : function(component,event,helper)
    {
		alert('Second Helper Method');
    },
    
    
})