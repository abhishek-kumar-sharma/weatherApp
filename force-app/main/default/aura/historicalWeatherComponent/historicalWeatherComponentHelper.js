({
    /**
     * helper method to handle the apex connect for get weather history button
     * Created Date : 16 may 2020
     * Created By : Abhishek Kumar Sharma
     * @param {*} c 
     * @param {*} e 
     * @param {*} h 
     */
    getWeatherHistory_Helper: function (c, e, h) {
        try {

            let startDateInEpochFormat = new Date (c.get('v.startDate')).getTime()/1000.0;
            let endDateInEpochFormat = new Date (c.get('v.endDate')).getTime()/1000.0;

            let call_Apex = c.get('c.getHistoricalDataViaCityName_Apex');
            call_Apex.setParams({
                "city" : c.get('v.city'),
                "startDate" : startDateInEpochFormat,
                "endDate" : endDateInEpochFormat
            });
            call_Apex.setCallback(this, function(response){
            console.log('state :::'+response.getState());
            console.log('state :::'+JSON.stringify(response.getReturnValue()));
            console.log('state :::'+response.getState());
            });

            $A.enqueueAction(call_Apex);
        } catch (e) {
                console.error('Exception :::::',e.message);
        }
    }
})
