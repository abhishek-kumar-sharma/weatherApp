({
    createNewAccount_Helper: function (c, e, h) {
        console.log('createNewAccount_Helper');
        var account = c.get('v.newAccount');
        console.log('account data ---> ' + JSON.stringify(account));


        var call_Apex = c.get('c.createAccount');
        call_Apex.setParams({'accountObject': account});

        call_Apex.setCallback(this, function (response) {
            try {
                var state = response.getState();
                if (state === 'SUCCESS' && c.isValid()) {
                    var serverResponse = response.getReturnValue();
                    if (serverResponse !== null && serverResponse == 'Account Successfully created') {
                        console.log(serverResponse);
                        $('#showModal').hide();
                        $("#successToast").show();
                        window.setTimeout(
                            $A.getCallback(function () {
                                $("#successToast").hide();
                            }), 3000
                        );

                    }
                    else {
                        console.log('Error in server response ------> ' + serverResponse);
                    }

                }
                else {
                    console.log('Error occurred in call back ----> state  ---> ' + state);
                }
            }
            catch (e) {
                console.log('Exception occurred while setting call back --> Message ----> ' + e.message);

            }

        });
        $A.enqueueAction(call_Apex);


    }
})