({
    /*Method to reset all attribute and form */
    resetAll: function (c, e, h) {
        c.set("v.senderShortName", null);
        c.set("v.routeCode", null);
        c.set("v.countryCode", +91);
        c.set("v.receiverMobileNumber", null);
        c.set("v.msgBody", null);

    },
    /* Method to handle sms sending */
    sendMessageController: function (c, e, h) {
        h.sendMessageHelper(c, e, h);
    },
    // getcc : function (c,e,h) {
    //     alert('hi country --> '+c.get("v.countryCode"));
    // }

})