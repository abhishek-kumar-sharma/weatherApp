({
    /**
     * Method to load All account
     */
    doInit_Helper: function (c, e, h) {
        try {
            let action = c.get("c.getAllAccount_Apex");
            action.setCallback(this, function (response) {
                let state = response.getState();
                let serverResponse = response.getReturnValue();
                if (state === "SUCCESS" && !$A.util.isUndefinedOrNull(serverResponse) && c.isValid()) {
                    c.set('v.dataTableColumns', [
                        {label: 'Account name',fieldName: 'Name',type: 'text',editable: true,typeAttributes: {required: true}},
                        {label: 'Phone', fieldName: 'Phone', type: 'tel', editable: true},
                        {label: 'Rating', fieldName: 'Rating', type: 'number', editable: true},
                        {label: 'Website',fieldName: 'website',type: 'url',typeAttributes: {target: '_parent'},editable: true},
                        {label: 'AccountNumber', fieldName: 'AccountNumber', type: 'number', editable: true},
                        {label: 'Active Status', fieldName: 'ECSV__Active_Status__c', type: 'boolean', editable: true}
                    ]);
                    c.set("v.dataTableData", serverResponse);
                    console.log(serverResponse);
                }
                else {
                    console.warn("Error message: state ---> " + state);
                }
            });
            $A.enqueueAction(action);
        } catch (exce) {
            console.error('Exception occurred while fetching the Account in do init : \nMessage :::' + exce.message);
        }
    },

    /**
     * Method to handle the on save event of data table
     * @param c
     * @param e
     * @param h
     */
    onSaveOfDataTable_Helper: function (c, e, h) {
        try {
            let draftValues = e.getParams("draftValue");
            let dataTableData = c.get("v.dataTableData");
            let dataTableColumns = c.get("v.dataTableColumns");
            console.log('Data Table data ===>');
            console.log({dataTableData});
            let indexList = [];
            console.log('Ready to send test ==>'+JSON.stringify(draftValues));
            if (!$A.util.isUndefinedOrNull(draftValues) && !$A.util.isUndefinedOrNull(draftValues.draftValues)) {
                draftValues.draftValues.forEach(function (elem) {
                    if(!$A.util.isUndefinedOrNull(elem.id.substring(4))){
                        indexList.push(elem.id.substring(4));
                        elem.id = dataTableData[elem.id.substring(4)].Id;
                    }
                });
            }
            console.log('Ready to send test ==>'+JSON.stringify(indexList));
            if (!$A.util.isUndefinedOrNull(draftValues) && !$A.util.isUndefinedOrNull(indexList) && indexList.length > 0 && !$A.util.isUndefinedOrNull(draftValues.draftValues) && !$A.util.isUndefinedOrNull(dataTableData)) {
                indexList.forEach(function (index) {
                    console.log(index);
                    for ( let j = 0; j < draftValues.draftValues.length; j++) {
                        if (dataTableData[index].Id === draftValues.draftValues[j].id) {
                            dataTableColumns.forEach(function (elem) {
                                if (!$A.util.isUndefinedOrNull(draftValues.draftValues[j][elem.fieldName])) {
                                    dataTableData[index][elem.fieldName] = draftValues.draftValues[j][elem.fieldName];
                                }
                            });
                        }
                    }
                });
               /* draftValues.draftValues.forEach(function (elem) {
                    elem.id = dataTableData[elem.id.substring(4)].Id;
                });*/
                console.log('Ready to send test ==>'+JSON.stringify(draftValues));
                console.log({dataTableData});

              let call_Apex = c.get("c.saveEditedAccounts");
               call_Apex.setParams({
                   'modifiedAccountData': JSON.stringify(dataTableData)
               });
                call_Apex.setCallback(this,function (response) {
                   let state = response.getState();
                   let serverResponse = response.getReturnValue();
                   console.log('state --->'+state+'\nserverResponse ==>'+serverResponse);
                });
                $A.enqueueAction(call_Apex);

            }
        } catch (exce) {
            console.log("Exception occurred in save method of data table \nMessage ::" + exce.message);
        }


    }
})