/**
 * Created by Abhishek Kumar Sharma  on 6/8/2018.
 */
({
    /* method to get calender of selected date range */
    getCalender_Helper : function (c,e,h) {
        var startDate = c.get("v.startDate");
        var endDate = c.get("v.endDate");
        try {
            if (!$A.util.isUndefinedOrNull(startDate) && startDate.trim() !== '' && !$A.util.isUndefinedOrNull(endDate) && endDate.trim() !== '') {
                console.log('start Date is not null --> ' + startDate);
                console.log('end Date is not null --> ' + endDate);
                if (endDate < startDate)
                {
                    alert('End Date must be greater than or equal to start date ');
                    return;
                }

                var callApex = c.get("c.getFullCalender_Apex");
                callApex.setParams({
                    "sdate":startDate,
                    "edate":endDate
                });
                callApex.setCallback(this ,function (response) {
                    console.log('response ---> '+response);
                    var state = response.getState();
                    if (state === 'SUCCESS' && c.isValid())
                    {
                        console.log('returned value ---> '+response.getReturnValue());
                    }
                    else{
                        console.log('Unable to set call back in get calender helper ---> state ---> '+state);
                    }

                })
                $A.enqueueAction(callApex);
            }
            else {
                console.log('else block null or undefined  ---> \nstart Date -->' + startDate + ' \tend date ---> ' + endDate);
            }
        }
        catch (exce) {
            console.log('Exception occurred in getCalender helper ....\nMessage --> '+exce.message);
        }

    }

})