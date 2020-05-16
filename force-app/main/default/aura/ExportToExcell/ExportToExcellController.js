({
    /* Method to get all fields of object */
    getAllFields: function (c, e, h) {
        h.getAllFields_Helper(c, e, h);
    },
    Reset: function (c, e, h) {
        c.set("v.objectName", null);
        $("#export").hide();
        $("#outputPanel").hide();


    },
    scriptsLoaded : function (c,e,h) {
        console.log('loaded');
    }
})