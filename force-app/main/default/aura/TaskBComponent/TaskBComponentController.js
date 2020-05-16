({
	loginHandler : function(component, event, helper) {
        
        /*var condata = component.get("{!v.loginCon}");
        console.log('----------------------> ');
        console.log(JSON.stringify(condata));*/
        helper.checkLogin(component, event, helper);
	}
})