({
    init: function (component, event, helper) {
        component.set('v.mycolumns', [
            {label: 'Account Name', fieldName: 'Name'},
            {label: 'Type', fieldName: 'Type'},
            {label: 'Industry', fieldName: 'Industry'},
            {label: 'AnnualRevenue', fieldName: 'AnnualRevenue'},
            {label: 'Phone', fieldName: 'Phone'}
        ]);
        helper.getAccountData(component,event,helper);
        
    },
    sortData : function(component,event,helper)
    {
        helper.sortDatahelper(component,event,helper);
    },
    apexSortData : function(component,event,helper)
    {
        helper.apexSort(component,event,helper);
    },
    getSelectedName : function(component,event,helper)
    {

    }

})