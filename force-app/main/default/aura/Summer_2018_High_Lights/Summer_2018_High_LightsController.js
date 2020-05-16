({
    /**
     * Method to load All account
     */
    doInit :  function (c,e,h) {
        h.doInit_Helper(c,e,h);
    },

    /**
     * Method to handle on save event from data table
     * @param c
     * @param e
     * @param h
     */
    onSaveOfDataTable_Controller : function (c,e,h) {
        h.onSaveOfDataTable_Helper(c,e,h);
    },

    /**
     * Method to handle on cancel event
     * @param c
     * @param e
     * @param h
     */
    onCancelOfDataTable_Controller : function (c,e,h) {
        console.log('Cancel event captured');
    }

})