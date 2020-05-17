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
                if (response.getState() === 'SUCCESS' && c.isValid()) {
                    // Getting the data to convert the Epoch time to human format
                    let resultList = response.getReturnValue();
                    console.log(resultList);
                    resultList.list_New.forEach(function (dataSet) {
                        dataSet.dt = h.formatDate(dataSet.dt);
                    });
                    c.set('v.result', resultList);
                    c.set('v.showResultSection', true);

                    $A.util.addClass(globalSpinner, 'slds-hide');
                    $A.util.removeClass(globalSpinner, 'slds-show');
                    console.log('state :::' + JSON.stringify(response.getReturnValue()));
                } else {
                    c.set('v.toastThemeClass','slds-notify slds-notify_toast slds-theme_error');
                    c.set('v.toastMessage','Unable to get data.');
                    c.set('v.showToast',true);
                    window.setTimeout(
                        $A.getCallback(function() {
                            c.set('v.showToast',false);
                        }), 5000
                    );
                }

            });

            $A.enqueueAction(call_Apex);
        } catch (e) {
            console.error('Exception :::::', e.message);
        }
    },

    saveResult_Helper: function (c, e, h,isPrint) {
        try {
            let weather_History = {};
            weather_History.ECSV__calctime__c = ''+c.get('v.result').calctime;
            weather_History.ECSV__city_id__c = ''+c.get('v.result').city_id;
            weather_History.ECSV__cnt__c = ''+c.get('v.result').cnt;
            weather_History.ECSV__cod__c = ''+c.get('v.result').cod;
            weather_History.ECSV__message__c = ''+c.get('v.result').message;
            weather_History.Name = ''+c.get('v.result').city_id;

            let additional_Weather_History_Data = [];
            c.get('v.result').list_New.forEach(function (elem) {
                let additional_Weather_History_DataObj = {};
                additional_Weather_History_DataObj.ECSV__Clouds__c = ''+elem.clouds.all;
                additional_Weather_History_DataObj.ECSV__Date__c = ''+elem.dt;
                additional_Weather_History_DataObj.ECSV__Humidity__c = ''+elem.main.humidity;
                additional_Weather_History_DataObj.ECSV__Pressure__c = ''+elem.main.pressure;
                additional_Weather_History_DataObj.ECSV__Sea_Level__c = ''+elem.main.sea_level;
                additional_Weather_History_DataObj.ECSV__Temp__c = ''+elem.main.temp;
                additional_Weather_History_DataObj.ECSV__Temp_max__c = ''+elem.main.temp_max;
                additional_Weather_History_DataObj.ECSV__Temp_min__c = ''+elem.main.temp_min;
                additional_Weather_History_DataObj.ECSV__Weather__c = ''+elem.weather[0].description;
                additional_Weather_History_DataObj.ECSV__Wind_Speed__c = ''+elem.wind.speed;
                additional_Weather_History_Data.push(additional_Weather_History_DataObj);
            });


            let call_Apex = c.get('c.saveHistoricalWeatherData');
            call_Apex.setParams({
                "weatherHistory": weather_History, 
                "addWeatherHistory": additional_Weather_History_Data,
            });
            call_Apex.setCallback(this, function (response) {
                if (response.getState() === 'SUCCESS' && c.isValid()) {
                    c.set('v.recordId',response.getReturnValue());
                    window.open('/apex/ECSV__historicalDataPDF?id='+response.getReturnValue());
                    console.log('recordId ===>',c.get('v.recordId'));
                    console.log('response.getReturnValue() ===>',response.getReturnValue());
                    
                    if(!isPrint){
                        c.set('v.showToast',true);
                    }
                    window.setTimeout(
                        $A.getCallback(function() {
                            c.set('v.showToast',false);
                        }), 5000
                    );
                } else {
                    c.set('v.toastThemeClass','slds-notify slds-notify_toast slds-theme_error');
                    c.set('v.toastMessage','Unable to save record.');
                    c.set('v.showToast',true);
                    window.setTimeout(
                        $A.getCallback(function() {
                            c.set('v.showToast',false);
                        }), 5000
                    );
                }

            });

            $A.enqueueAction(call_Apex);
        } catch (e) {
            console.error('Error occurred while saving the record. \n Message ::', e.message);
        }
    },

    /**
     * Helper method to handle the date format
     * Created Date : 17 May 2020
     * Created By : Abhishek Kumar Sharma
     * @param timeStamp
     */
    formatDate: function (timeStamp) {
        /* formatting sunrise time*/
        let monthMap = new Map();
        monthMap.set(0, 'JAN');
        monthMap.set(1, 'FEB');
        monthMap.set(2, 'MAR');
        monthMap.set(3, 'APR');
        monthMap.set(4, 'MAY');
        monthMap.set(5, 'JUN');
        monthMap.set(6, 'JUL');
        monthMap.set(7, 'AUG');
        monthMap.set(8, 'SEP');
        monthMap.set(9, 'OCT');
        monthMap.set(10, 'NOV');
        monthMap.set(11, 'DEC');
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
    }
})
