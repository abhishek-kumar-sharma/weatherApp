({
    //method to load Account data
    loadAccount : function(component,event,helper)
    {
        helper.loadAccHelper(component,event,helper);
    },

    //method to select all checkbox
    selectAll: function(component, event, helper) {
        var selectAllStatus = event.getSource().get("v.value");
        console.log("Select all status --> "+selectAllStatus);

        var tableData = component.get("v.tableData");

        if(selectAllStatus === true)
        {
            tableData.forEach(function (element) {
                element.checkBox = true;
            })
            component.set("v.tableData",tableData);
        }
        else
        {
            tableData.forEach(function (element) {
                element.checkBox = false;

            })
            component.set("v.tableData",tableData);
        }

    },
    //method to get selected data
    showModalButtonHandler : function (component,event,helper)
    {

        var tableDataCmp  = component.get("v.tableData");
        console.log('----> table component data -----> '+JSON.stringify(tableDataCmp));

        //modal variables
        var modalData = [];
        tableDataCmp.forEach(function (element) {
            if (element.checkBox == true)
            {
                var temp = {Name:element.accObject.Name,status:element.accObject.Status__c};
                console.log('Element --> '+JSON.stringify(temp));
                modalData.push(temp);
            }
        })
        console.log('Modal Data ---> '+JSON.stringify(modalData));
        if(modalData.length > 0) {
            component.set("v.showModal", true);
            component.set("v.modalData", modalData);
        }
        else
        {
            alert('Select account');
        }



    },
    closeModel : function (component,event,helper)
    {
        component.set("v.showModal");
    }

})