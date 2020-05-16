/**
 * Created by abhishek on 8/3/18.
 */
({

    /* method to load all object*/
    loadObjectController: function (component, event, helper) {

        helper.loadObjectHelper(component, event, helper);
        /* initializing dual list*/
        var dualList = [];
        dualList.push({value: "", label: ""});
        component.set("v.selectedObjectField", dualList);
        component.set("v.showDualListBox", true);
    },

    /*method to load selected object field*/
    loadFieldsController: function (component, event, helper) {
        helper.loadFieldsHelper(component, event, helper);

    },

    /*method to load data after field selection in dual list box*/
    loadDataController: function (component, event, helper) {
        helper.loadDataHelper(component, event, helper);

    },
    /*sorting table data */
    sortTableData: function (component, event, helper) {
        var tableData = component.get("v.tableData");
        tableData.sort();
        component.set("v.tableData", tableData);

    },

})