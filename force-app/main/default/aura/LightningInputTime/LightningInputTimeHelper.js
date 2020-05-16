({
    saveRecord_Helper: function (c, e, h) {
        try {
            var allValid = c.find('field').reduce(function (validSoFar, inputCmp) {
                inputCmp.reportValidity();
                return validSoFar && inputCmp.checkValidity();
            }, true);
            if (allValid) {
                /**
                 * calling apex to upsert data
                 */
                var action = c.get("c.saveTime_Apex");
                action.setParams({
                    "objectData": JSON.stringify(c.get('v.dataLink'))
                });

                action.setCallback(this, function (response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        var serverResponse = response.getReturnValue();
                        console.log(serverResponse);
                        if (!$A.util.isUndefinedOrNull(serverResponse)) {
                            alert('Saved');
                            //c.set("v.dataLink", serverResponse);
                        }
                    }
                    else {
                        console.log(response.getError());
                    }
                });
                $A.enqueueAction(action);

            } else {
                console.info('Please update the invalid form entries and try again.');
            }
        }
        catch (exce) {
            console.log(' Exception occurred in saveRecord_Helper ------>' + exce.message);
        }

    },
})