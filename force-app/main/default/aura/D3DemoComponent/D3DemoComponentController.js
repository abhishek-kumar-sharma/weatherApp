/**
 * Created by ABHISHEK KUMAR SHARMA on 25-01-2020.
 */
({
    /**
     * Method to handle the init event
     * @param c
     * @param e
     * @param h
     */
    doInitController: function (c, e, h) {
        try {

        } catch (e) {
            console.error('Error occurred while handling the init event. \n Message ::', e.message);
        }
    },

    /**
     * Method to handle the script load
     * @param c
     * @param e
     * @param h
     */
    afterScriptLoadedController: function (c, e, h) {
        try {
            console.log('Loaded');
        } catch (e) {
            console.error('Error occurred while handling the after script event. \n Message ::', e.message);
        }
    }
})