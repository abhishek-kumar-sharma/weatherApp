({
    /*Method to load city on init*/
    getDefaultAccountCity_Helper : function(component,event,helper)
    {
        
        console.log('getDefaultAccountCity_Helper called \n weather app hosted');var recordId = component.get('v.recordId');
        console.log('recordId---'+recordId);
       // console.log();
        if(recordId !== null || recordId !== undefined)
        {
            console.log('recordId'+recordId);
            
            var call_Apex = component.get('c.getCityAddress_Apex');
            call_Apex.setParams({'recordId':recordId});
            
            call_Apex.setCallback(this,function (response) {
                try {
                    var state = response.getState();
                    if(state === 'SUCCESS')
                    {
                        var serverResponse = response.getReturnValue();
                        if(serverResponse !== null){
                            console.log('do init () serverResponse------> '+serverResponse);
                            component.set('v.cityName',serverResponse);    
                        }else {
                            component.set('v.cityName','Ghaziabad');
                        }
                        
                    }
                    else
                    {
                        component.set('v.cityName','Ghaziabad');
                        console.log('state -----> '+state);
                    }
                    
                }
                catch (ex) {
                    component.set('v.cityName','Ghaziabad');
                    console.log('Exception occurred ---> '+ex.message);
                    
                }
            });
            $A.enqueueAction(call_Apex);
            
            
        }
        else
        {
            component.set('v.cityName','Ghaziabad');
            console.log('recordId'+recordId);
        }
    },
    
    /* Method to get weather */
    getWheteherHelper: function (component, event, helper)
    {
        /*Getting value and setting input box null*/
        var cityName = component.get('v.cityName');
        //component.find("cityName").set("v.value", null);
        //component.find("countryName").set("v.value",null);
        console.log('Received Data in Helper --> city Name ' + cityName);
        
        /* Sending data to apex */
        if (cityName === null || cityName === undefined || cityName === '') {
            console.log('City Name Required ');
            component.set("v.showPrompt", true);
            component.set("v.errMsg", 'CITY NAME IS REQUIRED ...');
            //component.set("v.detailView",true);
        }
        else {
            try {
                var call_Apex = component.get("c.getData_Apex");
                call_Apex.setParams({'city': cityName});
                
                call_Apex.setCallback(this, function (response) {
                    var state = response.getState();
                    if (state === 'SUCCESS') {
                        console.log('success');
                        var serverReponse = response.getReturnValue();
                        if(serverReponse !== null)
                        {
                            console.log('server response----> ' + JSON.stringify(serverReponse));
                            
                            /* formatting sunrise time*/
                            var timeTemp = serverReponse.sys.sunrise;
                            var date = new Date(timeTemp * 1000);
                            var hours = date.getHours();
                            var minutes = "0" + date.getMinutes();
                            var seconds = "0" + date.getSeconds();
                            //getting date
                            var monthDate = date.getUTCDate();//19
                            var month = date.getUTCMonth();
                            var yr = date.getFullYear();
                            //getting time 00:00:00 format
                            var formattedTime = hours + ':' + minutes.substr(-2) + ':' + seconds.substr(-2);
                            var fullDate = monthDate + '/' + month + '/' + yr + ' ' + formattedTime;
                            component.set("v.sunrise", fullDate);
                            
                            /* formatting sunset time*/
                            var timeTemp1 = serverReponse.sys.sunset;
                            var date1 = new Date(timeTemp1 * 1000);
                            var hours1 = date1.getHours();
                            var minutes1 = "0" + date1.getMinutes();
                            var seconds1 = "0" + date1.getSeconds();
                            //getting date
                            var monthDate1 = date1.getUTCDate();//19
                            var month1 = date1.getUTCMonth();
                            var yr1 = date1.getFullYear();
                            //getting time 00:00:00 format
                            var formattedTime1 = hours1 + ':' + minutes1.substr(-2) + ':' + seconds1.substr(-2);
                            var fullDate1 = monthDate1 + '/' + month1 + '/' + yr1 + ' ' + formattedTime1;
                            component.set("v.sunset", fullDate1);
                            
                            
                            component.set("v.weatherResponse", serverReponse);
                            component.set("v.shorterView", true);
                        }
                        else
                        {
                            component.set("v.errMsg", 'CITY NAME NOT FOUND ,TRY AGAIN  ....');
                            component.set("v.showPrompt", true);
                        }
                        
                    }
                    else {
                        console.log('Unable to get data ---> state -->' + state);
                        component.set("v.errMsg", 'ENTER A VALID CITY NAME ....');
                        component.set("v.showPrompt", true);
                        
                    }
                    
                });
                $A.enqueueAction(call_Apex);
            }
            catch (ex) {
                console.log('Exception occurred while calling apex ');
            }
            
        }
        
    },
    
})




/* Method to predict all matching city on basic of input*/
/*predictCityByInput_helper : function (component,event,helper)
    {
        var cityName = component.get("v.cityName");
        console.log('cityName::::::::::::::::::::'+cityName);
        if(cityName !== null)
        {
            var call_Apex = component.get("c.predictCities_Apex");
            call_Apex.setParams({'cityNameString':cityName});
            
            call_Apex.setCallback(this,function (response) {
               try
               {
                   var state = response.getState();
                   if(state === 'SUCCESS')
                   {
                       var serverResponse = response.getReturnValue();
                       console.log('Server Response ---> '+serverResponse);

                   }
                   else
                   {
                       console.log('Error Occurred ---> '+state);
                   }
               }
               catch(ex)
               {
                   console.log('Exception Occurred ---> '+ex.message);
               }
            });
            $A.enqueueAction(call_Apex);
        }
    }*/