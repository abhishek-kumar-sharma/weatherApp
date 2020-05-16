({
    init : function(component, event, helper)
    {
        helper.loadOppData(component,event,helper);
    },
    getSelectedRow : function(component,event,helper)
    {
        var selectedRow = event.getParam('selectedRows');
        console.log('selected row'+JSON.stringify(selectedRow));
    }
    
    
})