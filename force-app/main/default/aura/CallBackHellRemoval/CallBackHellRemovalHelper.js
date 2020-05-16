({
    /**
     * With call back hell
     * @param c
     * @param e
     * @param h
     */
    getData_Helper: function (c, e, h) {
        try {
            /**
             * Calling the apex method for Account (firs time)
             */
            var call_ApexForGetAccount = c.get("c.getAccounts_Apex");
            call_ApexForGetAccount.setCallback(this, function (responseAccount) {
                /**
                 * calling the second apex method to get opportunity on basic of account
                 */
                var call_ApexForOpportuntity = c.get("c.getOpportunityOnBasicOfAccountId_Apex");
                call_ApexForOpportuntity.setParams({
                    accountList: responseAccount.getReturnValue()
                });
                call_ApexForOpportuntity.setCallback(this, function (responseOpportunity) {
                    /**
                     * Calling the third apex method to get opportunity line item
                     */
                    var call_ApexForOpportunityLineItem = c.get("c.getOppotunityLineItemOnBasicOfOpportunityId_Apex");
                    call_ApexForOpportunityLineItem.setParams({
                        opportunityList: responseOpportunity.getReturnValue()
                    });
                    call_ApexForOpportunityLineItem.setCallback(this, function (oliResponse) {
                        /**
                         * Calling the apex fourth time for product detail
                         */
                        var call_ApexForProductDetail = c.get("c.getProductDetailsOnBasicOfOpportunityLineItem_Apex");
                        call_ApexForProductDetail.setParams({
                            oliList: oliResponse.getReturnValue()
                        });
                        call_ApexForProductDetail.setCallback(this, function (responseProduct) {
                            console.log("Product Data List ---> " + JSON.stringify(responseProduct.getReturnValue()));
                            c.set("v.productList", responseProduct.getReturnValue());
                        })
                        $A.enqueueAction(call_ApexForProductDetail);
                        console.log('Opportunity Line Item -->' + JSON.stringify(oliResponse.getReturnValue()))
                        c.set("v.oliList", oliResponse.getReturnValue());
                    })
                    $A.enqueueAction(call_ApexForOpportunityLineItem);
                    console.log('Opportunity Data List -->' + JSON.stringify(responseOpportunity.getReturnValue()));
                    c.set("v.opportunityList", responseOpportunity.getReturnValue());
                });
                $A.enqueueAction(call_ApexForOpportuntity);
                console.log('Account Data List -_>' + JSON.stringify(responseAccount.getReturnValue()));
                c.set("v.accountList", responseAccount.getReturnValue());
            });
            $A.enqueueAction(call_ApexForGetAccount);
        }
        catch (exce) {
            console.log('Exception occurred in getData_Helper:\nMessage ::::' + exce.message);
        }
    },

    /**
     * Without call back hell
     * @param c
     * @param e
     * @param h
     * @returns {*|void|LaxPromise}
     */
    loadData_Helper: function (c, e, h) {
        c.lax.enqueue('c.getAccounts_Apex')
            .then(AccountResponse => {
            c.set('v.accountList', AccountResponse);
            console.log('AccountResponse --> ' + JSON.stringify(AccountResponse));
            return c.lax.enqueue('c.getOpportunityOnBasicOfAccountId_Apex', {accountList: AccountResponse})
    })
    .then(opportunityResponse => {
            console.log('Opportunity List -> ' + JSON.stringify(opportunityResponse));
            c.set('v.opportunityList', opportunityResponse);
            return c.lax.enqueue('c.getOppotunityLineItemOnBasicOfOpportunityId_Apex', {opportunityList: opportunityResponse})
    })
    .then(oliResponse => {
            console.log('opportunity line item ->' + JSON.stringify(oliResponse));
            c.set("v.oliList",oliResponse);
            return c.lax.enqueue('c.getProductDetailsOnBasicOfOpportunityLineItem_Apex',{oliList:oliResponse })
    }).then(productResponse => {
            console.log('productResponse --->'+JSON.stringify(productResponse));
            c.set("v.productList",productResponse);
        })
    .catch(errors => {
            console.error(errors);
    });

    },
})