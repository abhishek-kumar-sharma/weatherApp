({
    
    /* Method to display current time */
    doInit : function (component, event, helper)
    {
        console.log('do init called \n weather app hosted');
        startTime();
        function startTime() {
            var today = new Date();
            var h = today.getHours();
            var m = today.getMinutes();
            var s = today.getSeconds();
            m = checkTime(m);
            s = checkTime(s);
            var currentTime = h + ":" + m + ":" + s;
            component.set('v.currentTime', currentTime);
            //console.log(currentTime);
            var t = setTimeout(startTime, 500);
        }
        function checkTime(i) {
            if (i < 10) {i = "0" + i};  // add zero in front of numbers < 10
            return i;
        }
        helper.getDefaultAccountCity_Helper(component, event, helper);
    },
    
    /* Method to get weather api data */
    getWhetherController : function (component,event,helper)
    {
        helper.getWheteherHelper(component,event,helper);
        
    },
    
    /* Method to Hide the modal on wrong */
    hidePrompt : function(component,event,helper)
    {
        component.set("v.showPrompt",false);
    },
    
    /* Method to show/hide detail weather */
    getWeatherData : function (component,event,helepr)
    {
        
        var toggleButtonData = component.find("showHideWeather").get("v.value");
        //alert('toggleButtonData -> '+toggleButtonData);
        if(toggleButtonData == true)
        {
            component.set("v.detailView",true);
        }
        if(toggleButtonData == false)
        {
            component.set("v.detailView",false);
        }
        
        
    },
    
    /* method to reset all attribute */
    resetAll : function (component,event,helper)
    {
        
        component.set("v.cityName",null);
        component.set("v.weatherResponse",null);
        component.set("v.shorterView",null);
        component.set("v.detailView",null);
        component.set("v.sunrise",null);
        component.set("v.sunset",null);
        
    },
    
})


/* Method to predict all city in world on input basis
     
      startTime();
        function startTime() {
            var today = new Date();
            var h = today.getHours();
            var m = today.getMinutes();
            var s = today.getSeconds();
            m = checkTime(m);
            s = checkTime(s);
            document.getElementById('txt').innerHTML =
            var currentTime = h + ":" + m + ":" + s;
            c.set('v.currentTime', currentTime);
            //console.log(currentTime);
            var t = setTimeout(startTime, 500);
        }
        function checkTime(i) {
            if (i < 10) {i = "0" + i};  // add zero in front of numbers < 10
            return i;
        }
     
     
     predictCityByInput : function (component,event,helper)
    {
        helper.predictCityByInput_helper(component, event, helper);
    }


    /*inputChanged : function(component, event, helper) {

        //var input = event.target.id; //this is = one-id
        //var inputValue = component.find("showHideWeather").get("v.value");
        //var whichOne = event.getSource().getLocalId();


        var inputValue = document.getElementsByClassName('checkboxnew1')[0].value;

         var whichOne = event.getSource().getLocalId();
         console.log('inputValue : ', whichOne);

        /* var inputValue = document.getElementById(input).value;
         var output = document.getElementById(input + "-op");
         var outputValue = output.value;



    console.log('inputValue : ', inputValue);

    }*/