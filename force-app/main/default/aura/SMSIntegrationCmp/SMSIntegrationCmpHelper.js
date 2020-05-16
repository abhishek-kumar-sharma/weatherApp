({
    sendMessageHelper: function (c, e, h) {
        var senderShortName = c.get("v.senderShortName");
        var routeCode = c.get("v.routeCode");
        var countryCode = c.get("v.countryCode", +91);
        var receiverMobileNumber = c.get("v.receiverMobileNumber");
        var msgBody = c.get("v.msgBody");
        console.log('sender Short Name ---> ' + senderShortName + ' Route code --> ' + routeCode + ' country code --> ' + countryCode + ' receiver mobile number ---> ' + receiverMobileNumber + ' msg body -->' + msgBody);

        var call_Apex = c.get("c.sendSMS_Apex");
        call_Apex.setParams({
            "senderShortName": senderShortName,
            "routeCode": routeCode,
            "countryCode": countryCode,
            "receiverMobileNumber": receiverMobileNumber,
            "msgBody": msgBody
        });

        call_Apex.setCallback(this, function (response) {
            try {
                var state = response.getState();
                if (state === 'SUCCESS' && c.isValid()) {
                    console.log('state-->' + state);
                    c.set("v.senderShortName", null);
                    c.set("v.routeCode", null);
                    c.set("v.countryCode", +91);
                    c.set("v.receiverMobileNumber", null);
                    c.set("v.msgBody", null);
                    alert('SMS send successfully...');
                }
                else {
                    console.log('Unable to set call back --> State --> ' + state);
                }

            }
            catch (ex) {
                console.log('Exception Occurred in JS Helper ' + ex.message);
            }

        })
        $A.enqueueAction(call_Apex);

    }
})