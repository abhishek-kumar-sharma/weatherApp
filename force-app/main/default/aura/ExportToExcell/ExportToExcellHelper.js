({
    /* Method to get object all fields */
    getAllFields_Helper: function (c, e, h) {

        var objectName = c.get("v.objectName");
        if (objectName === null || objectName === undefined) {
            console.log("Unable to get object name ---> received data ---> " + objectName);
            $("#export").hide();
            $("#outputPanel").hide();
        }
        else {

            console.log("received data -----> " + objectName);
            var call_Apex = c.get("c.loadAllFields");
            call_Apex.setParams({"objectName": objectName});

            try {
                call_Apex.setCallback(this, function (response) {
                    var state = response.getState();
                    if (state === "SUCCESS" && c.isValid()) {
                        try {
                            var serverResponse = response.getReturnValue();
                            if (serverResponse === null || serverResponse === undefined) {
                                $("#export").hide();
                                $("#outputPanel").hide();
                            }
                            else {
                                c.set("v.responseData", serverResponse);
                                $("#export").show();
                                $("#outputPanel").show();

                                $("#export").click(function(){
                                     $("table").tableToCSV();
                                    console.log('Exported Sussessfully ');
                                });
                                console.log('serverResponse----> ' + JSON.stringify(serverResponse));

                            }

                        }
                        catch (ex) {
                            console.log("Exception occurred in call back --> Message--->" + ex.message);
                            $("#export").hide();
                            $("#outputPanel").hide();
                        }

                    }
                    else {
                        console.log("Error occurred while setting call back --> State ---> " + state);
                        $("#export").hide();
                        $("#outputPanel").hide();
                    }

                })
                $A.enqueueAction(call_Apex);
            }
            catch (e) {
                console.log('Exception occurred before call back ---> ' + e.message);
                $("#export").hide();
                $("#outputPanel").hide();
            }
        }


    }
})