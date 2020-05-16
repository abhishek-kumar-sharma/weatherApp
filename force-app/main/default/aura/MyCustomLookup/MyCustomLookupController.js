/**
 * Created by abhishek on 9/3/18.
 */
({
    /*Method to show modal*/
    showModalController : function (component,event,helper) {
        component.set("v.showModal",true);
        var stageOptions = ["Prospecting","Need Analysis","Value Proposition","Perception Analysis","Closed Won","Closed lost"];
       console.log(stageOptions);
        component.set("v.stage",stageOptions);


    },
    /*Method to hide modal*/
    hideModalController : function (component,event,helper) {
        component.set("v.showModal",false);
        component.set("v.newOpp",null);
        component.set("v.stage",null);
        component.set("v.accountData",null);
        component.set("v.showAccountList",false);

    },
    /*Method to handle opportunity creation*/
    createOppController :function (component,event,helper) {
        helper.createOppHelper(component,event,helper);

    },
    /*Method to load account*/
    loadAccountController : function (component,event,helper) {
        helper.loadAccountHelper(component,event,helper);

    },
    getSelectedAccountId : function (component,event,helper) {

        //var accId = event.getSource().get("v.value");
        var testaccId = component.get("v.accId");
        console.log('Selected account id '+testaccId);


    }

})