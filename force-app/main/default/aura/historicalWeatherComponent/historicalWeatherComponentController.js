({
    /**
     * Function to handle the initialization for the attribute
     * @created by 16 May 2020
     * @param {*} c 
     * @param {*} e 
     * @param {*} h 
     */
    doInit: function (c, e, h) {
        try {
            startTime();
            function startTime() {
                var today = new Date();
                var h = today.getHours();
                var m = today.getMinutes();
                var s = today.getSeconds();
                m = checkTime(m);
                s = checkTime(s);
                var currentTime = h + ":" + m + ":" + s;
                c.set('v.currentTime', currentTime);
                var t = setTimeout(startTime, 500);
            }
            function checkTime(i) {
                if (i < 10) { i = "0" + i };  // add zero in front of numbers < 10
                return i;
            }
        } catch (e) {
            console.error('Exception occurred while initalizing in do init. \n Message ::', e.message);
        }

    },

    /**
     * Function to handle the user input and validating the user input
     * @created by 16 May 2020
     * @param {*} c 
     * @param {*} e 
     * @param {*} h 
     */
    getWeatherHistory: function (c, e, h) {
        try {
            // Validating the input fields
            var allValid = c.find('field').reduce(function (validSoFar, inputCmp) {
                inputCmp.reportValidity();
                return validSoFar && inputCmp.checkValidity();
            }, true);
            if (allValid) {
                console.log('city ===>', c.get('v.city'));
                console.log('startDate ===>', c.get('v.startDate'));
                console.log('endDate ===>', c.get('v.endDate'));
                // Calling helper method if all inputs are valid
                h.getWeatherHistory_Helper(c,e,h);
            } else {
                console.error('Please update the invalid form entries and try again.');
            }

        } catch (e) {
            console.error('Exception occurred while handling the button click. \n Message ::', e.message);
        }
    }
})
