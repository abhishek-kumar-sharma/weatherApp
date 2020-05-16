({
    /** Method to initialize the login form with image */
    initializedLoginForm: function (c, e, h) {
        try {
            console.log('initializedLoginForm of login component');

        }
        catch (exce) {
            console.log('Exception occurred in initializedLoginForm method \nMessage : ' + exce.message);
        }
    },
    setTabIndexZero: function (c, e, h) {
        c.set("v.tabIndex", parseInt(0));
    },

    changeVideo: function (c, e, h) {
        var tabIndex = e.getSource().get('v.tabindex');
        console.log('event tab -->' + tabIndex);
        console.log('Attribute tab index -->' + c.get("v.tabIndex"));
        if (parseInt(tabIndex) === 1) {
            c.set("v.tabIndex", parseInt(1));
        } else if (parseInt(tabIndex) === 2) {
            c.set("v.tabIndex", parseInt(2));
        }
        else {
            c.set("v.tabIndex", parseInt(0));
        }

    },
    checkDetails: function (c, e, h) {

    }

})