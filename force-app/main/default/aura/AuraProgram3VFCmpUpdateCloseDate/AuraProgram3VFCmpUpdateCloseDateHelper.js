({
    updateButtonHelper : function(component,event,helper) 
    {
        //alert(component.get('v.pageId'));
        var id = component.get('v.pageId');
        var newDate = component.find("newDate").get("v.value");
        console.log('new date --> '+newDate);
        
        var action = component.get("c.updateDate");
        action.setParams({"dt":newDate,"oppID":id});

        action.setCallback(this,function(response){
            try
            {
                var state = response.getState();
                if(state === 'SUCCESS')
                {
                    //window.open("https://www.w3schools.com",'_blank');
                    //window.open('https://abhishekcloudanalogy-dev-ed.my.salesforce.com/'+id);
                    console.log('success');
                    window.close("/"+id);
                    location.reload("/"+id);

                }
            }
            catch(ex)
            {
                console.log(ex.message);
            }
        });
        $A.enqueueAction(action);

    },
})