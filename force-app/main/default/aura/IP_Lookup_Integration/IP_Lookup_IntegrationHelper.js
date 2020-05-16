/**
 * Created by ABHISHEK on 05-01-2019.
 */
({
    /**
     * Helper Method to get IP details
     * @param c
     * @param e
     * @param h
     */
    getIPDetails_Helper : function (c,e,h) {
        try{
            let inputtedIP = c.get('v.InputtedIP');
            let call_Apex;
            if ($A.util.isUndefinedOrNull(inputtedIP)){
                /**
                 * Calling apex without user input
                 */
                call_Apex = c.get('c.getIPDetails_Without_Param_Apex');
                call_Apex.setCallback(this,function (response) {
                    if (response.getState()){
                        console.log('response ==>',response.getReturnValue());
                    }else{
                        console.error('Error occurred while getting the call back from server' +
                            '\n State ::'+response.getState());
                    }

                });

            }else if (!$A.util.isUndefinedOrNull(inputtedIP)){
                /**
                 * Calling apex with user input
                 */
                call_Apex = c.get('c.getIPDetails_With_Param_Apex');
                call_Apex.setParams({
                   'inputtedIPLocation':inputtedIP
                });
                call_Apex.setCallback(this,function (response) {
                        if (response.getState()){
                            console.log('response ==>',response.getReturnValue());
                        } else{
                            console.error('Error occurred while getting the call back from server.\n State ::'+response.getState());
                        }
                });
            }
            /**
             * Adding action to execution queue
             */
            $A.enqueueAction(call_Apex);

        }catch (exce) {
            console.error('Exception occurred while fetching the IP details. \n Message :::'+exce.message);
        }
    },
})