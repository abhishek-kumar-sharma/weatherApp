({
    doInit :function(component,event,helper)
    {
        //method to initilize the option attribute of dual list on init
        var optionAttribInit = [];
        optionAttribInit.push({value: "" ,label: ""});
        component.set("v.optionList",optionAttribInit);
        //combo box initilization
        component.set("v.comboBoxOption",optionAttribInit);
    },
    fetchObjectHandler : function(component, event, helper)
    {
        //method to find inputted limit and to get objects
        helper.fetchObject(component,event,helper);
        
    },
    clearQueryData : function(component,event,helper)
    {
        //method to clear all data
        component.set("v.sObjectList",null);
        component.set("v.selectedObjectName",null);
        component.set("v.fieldList",null);
        component.set("v.ifBlock",false);
        component.set("v.APIAttribDataType",null);
        component.set("v.APIAttrib",null);
        component.set("v.selectedFieldName",null);
        var optionAttribInit = [];
        optionAttribInit.push({value: "" ,label: ""});
        component.set("v.optionList",optionAttribInit);
        component.set("v.showQueryBox",false);
        component.set("v.query",null);
        component.set("v.showResponseTable",false);
        component.set("v.rec_Query_Response",null);
        component.set("v.tableHeader",null);
        component.set("v.showConditionSec",false);
        component.set("v.selectedFilterField",null);
    },
    getSelectedObject : function(component,event,helper)
    {
        //method to  get fields of selected object
        
        //setting field value of object to attrib
        component.set("v.fieldList",null);
        helper.loadFields(component,event,helper);
        //setting if block true for displaying
        component.set("v.ifBlock",true);
        // helper.getDataType(component,event,helper);
        
    },
    getAPIName : function(component,event,helper)
    { 
        //method to get select fields API NAME AND DATA TYPE
        helper.getDataType(component,event,helper);
        
    },
    handleChange : function(component,event,helper)
    {        
        helper.fetchDataByQuery(component,event,helper);
    },
    getSelectedName : function(component,event,helper)
    {
        var selectedrow = event.getParam("selectedRows");
        console.log('-----------------------------> '+JSON.stringify(selectedrow));
    },
    //method to handle filter section
    handleFilterButton : function(component,event,helper)
    {
        component.set("v.showConditionSec",true);
        
    },
    //method to handle first filter pick list (only api name and type of selected field ) 
    getFilterFieldFirst : function(component,event,helper)
    {
        component.set("v.symbolsFirst",null);
        helper.getFilterFieldFistHelp(component,event,helper);
    },
    applyFilterButtonHandler : function(component,event,helper)
    {
        helper.applyFilterButtonHelper(component,event,helper);
    },
    handleComboBox : function(component,event,helper)
    {
        //alert('hi');
        helper.getComboBoxRelatedList(component,event,helper);
    }
    
})