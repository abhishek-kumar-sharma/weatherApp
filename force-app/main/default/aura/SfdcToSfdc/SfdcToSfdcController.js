({
    /*Method after script loaded */
    scriptsLoaded: function (c, e, h) {
        console.log('Jquery loaded ');
    },

    /*Method to show slds modal on button click*/
    showAccountModal: function (c, e, h) {
        $('#showModal').show();

    },

    /* Method to cancel the Account creation */
    cancelAccount: function (c, e, h) {
        $('#showModal').hide();

    },

    /* Method to create new account */
    createNewAccount: function (c, e, h) {
        h.createNewAccount_Helper(c, e, h);
    }
})