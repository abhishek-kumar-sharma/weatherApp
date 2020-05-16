/**
 * Created by ABHISHEK on 02-05-2019.
 */
({
    loadInitialData_Helper: function (c, e, h) {
        try {
            let call_Apex = c.get("c.getContact_With_All_Fields_Apex");
            call_Apex.setStorable();
            call_Apex.setParams({
                "endAt" :10,
                "startFrom" : 0
            });
            call_Apex.setCallback(this, function (response) {
                if (response.getState() === 'SUCCESS') {
                    console.log('Returned values ==> ', response.getReturnValue());
                    c.set('v.contacts', response.getReturnValue());
                } else if (response.getState() === 'INCOMPLETE') {
                    console.log('Unable to fulfill the fetch more request. Please re try after some time .');
                } else {
                    console.error('Error occurred while calling the apex. \n state ::' + response.getState() + ' Error object : ', response.getError());
                }
            });
            $A.enqueueAction(call_Apex);
        } catch (e) {
            console.error('Exception occurred while loading the initial data . \n Message ::' + e.message);
        }
    }
})