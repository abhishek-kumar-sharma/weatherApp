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
            let globalSpinner = c.find('global-spinner');
            $A.util.addClass(globalSpinner, 'slds-show');
            $A.util.removeClass(globalSpinner, 'slds-hide');
            let startDateInEpochFormat = new Date(c.get('v.startDate')).getTime() / 1000.0;
            let endDateInEpochFormat = new Date(c.get('v.endDate')).getTime() / 1000.0;

            let call_Apex = c.get('c.getHistoricalDataViaCityName_Apex');
            call_Apex.setParams({
                "city": c.get('v.city'),
                "startDate": startDateInEpochFormat,
                "endDate": endDateInEpochFormat
            });
            call_Apex.setCallback(this, function (response) {
                if(response.getState() === 'SUCCESS' && c.isValid()){
                    // Getting the data to convert the Epoch time to human format
                    let resultList = response.getReturnValue();
                    console.log(resultList);
                    resultList.list_New.forEach(function(dataSet){
                        dataSet.dt= h.formatDate(dataSet.dt);         
                    }); 
                    console.log('result list >>>'+JSON.stringify(resultList));
                    c.set('v.result',resultList);

                    $A.util.addClass(globalSpinner, 'slds-hide');
                    $A.util.removeClass(globalSpinner, 'slds-show');
                    console.log('state :::' + JSON.stringify(response.getReturnValue()));
                   // h.showToast(c,e,h,'Success','Data Received ...','success');
                }else{

                }
               
            });

            $A.enqueueAction(call_Apex);
        } catch (e) {
            console.error('Exception :::::', e.message);
        }
    },

    /**
     * Helper method to handle the date format
     * Created Date : 17 May 2020
     * Created By : Abhishek Kumar Sharma
     * @param timeStamp
     */
    formatDate : function(timeStamp){
        /* formatting sunrise time*/
        let monthMap = new Map();
        monthMap.set(0,'JAN');
        monthMap.set(1,'FEB');
        monthMap.set(2,'MAR');
        monthMap.set(3,'APR');
        monthMap.set(4,'MAY');
        monthMap.set(5,'JUN');
        monthMap.set(6,'JUL');
        monthMap.set(7,'AUG');
        monthMap.set(8,'SEP');
        monthMap.set(9,'OCT');
        monthMap.set(10,'NOV');
        monthMap.set(11,'DEC');
        let date = new Date(timeStamp * 1000);
        let hours = date.getHours();
        let minutes = "0" + date.getMinutes();
        let seconds = "0" + date.getSeconds();
        //getting date
        let monthDate = date.getUTCDate();//19
        let month = date.getUTCMonth();
        let yr = date.getFullYear();
        //getting time 00:00:00 format
        let formattedTime = hours + ':' + minutes.substr(-2) + ':' + seconds.substr(-2);
        let fullDate = monthDate + '-' + monthMap.get(month) + '-' + yr + ' ' + formattedTime;
        return fullDate;
    },

    /**
     * Method to show toast
     * @param {*} c 
     * @param {*} e 
     * @param {*} h 
     * @param {*} title 
     * @param {*} message 
     * @param {*} type 
     */
    showToast : function(c,e,h,title,message,type) {
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": title,
            "message": message,
            "type" : type
        });
        toastEvent.fire();
    }
})
