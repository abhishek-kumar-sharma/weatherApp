/**
 * Created by abhishek on 8/3/18.
 */
({
    /* controller name --> loadObjectController*/

    /* method to load all object*/
    loadObjectHelper : function (component,event,helper) {

        var call_Apex = component.get("c.loadObject_Apex");
        call_Apex.setCallback(this,function (response) {
            try
            {
                var state = response.getState();
                if(state === 'SUCCESS' && component.isValid())
                {
                    var serverResponse = response.getReturnValue();
                    serverResponse.sort();
                    component.set("v.Objects",serverResponse);
                }
                else
                {
                    console.log('Error occurred while loading Object in loadObjectHelper ---> '+state);
                }

            }
            catch (ex)
            {
                console.log('Catch Block of loadObjectHelper '+ex.message);
            }
        });
        $A.enqueueAction(call_Apex);


    },

    /*method to load selected object fields*/
    loadFieldsHelper : function (component,event,helper) {

        var selectedObjectName = component.get("v.selectedObject");
        console.log(selectedObjectName);
        var call_Apex = component.get("c.loadAllFields_Apex");
        call_Apex.setParams({"objectName":selectedObjectName});

        call_Apex.setCallback(this,function (response) {

            try
            {
                var state = response.getState();
                if(state === 'SUCCESS' && component.isValid())
                {
                    var serverResponse = response.getReturnValue();
                    var formatDataForDualList = [];
                    for(var i=0;i<serverResponse.length;i++)
                    {
                        var temp = {value:serverResponse[i],label:serverResponse[i]};
                        formatDataForDualList.push(temp);
                    }
                    console.log('Formatted data --> '+JSON.stringify(formatDataForDualList));
                    component.set("v.selectedObjectField",formatDataForDualList);
                }
                else
                {
                    console.log('Error in loadFieldsHelper --->'+state);
                }

            }
            catch (ex)
            {
                console.log('Catch Block Of loadFieldsHelper ---> '+ex.message);
            }
        });
        $A.enqueueAction(call_Apex);

    },

    /* method to load data for selected field in dual list*/
    loadDataHelper : function (component,event,helper) {

        /*Requested field and object from dual list*/
        var selectedObject = component.get("v.selectedObject");
        var requestedFields = component.get("v.selectedFields");

        if(selectedObject !== null || selectedObject !== undefined || selectedObject !== 'none')
        {
            /* query formation*/
            var query = 'SELECT '+requestedFields+' FROM '+selectedObject;
            component.set("v.showQueryBox",true);
            component.set("v.query",query);

            try
            {
                /*calling apex method for data*/
                var call_Apex = component.get("c.loadData_Apex");
                call_Apex.setParams({"rec_QueryString":query});

                call_Apex.setCallback(this,function (response) {
                    var state = response.getState();
                    if(state === 'SUCCESS' || component.isValid())
                    {
                        var sereverResponse = response.getReturnValue();
                        /* Formatting data for lightning table*/
                        var tableHeader =[];
                        var tableDat =[];
                        /*Table Header*/
                        for(var i=0;i<requestedFields.length;i++)
                        {
                            var temp = {label:requestedFields[i],fieldName:requestedFields[i]};
                            tableHeader.push(temp);
                        }
                        console.log('table header --> '+JSON.stringify(tableHeader));
                        console.log('table data -->'+JSON.stringify(sereverResponse));
                        component.set("v.tableHeader",tableHeader);
                        component.set("v.tableData",sereverResponse);


                    }
                    else
                    {
                        console.log('Error occurred in loadDataHelper --> state ---> '+state);
                    }

                })

            }
            catch (ex)
            {
                console.log('Catch block of loadDataHelper ---> '+ex.message);

            }
            $A.enqueueAction(call_Apex);


        }
        else
        {
            console.log('Null Object or field recieved in loadDataHelper ---> selected object -> '+selectedObject+ ' requested fields -->  '+requestedFields);
            return null;
        }

    }


})