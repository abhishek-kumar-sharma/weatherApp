/**
 * Created by ABHISHEK on 17-07-2019.
 */
({
    handleSuccess : function (c,e,h) {
        console.log('Parent opportunity id ==>'+c.get('v.recordId'));
        console.log('new record id ==>',e.getParam("id"));

        if ($A.util.isUndefinedOrNull(e.getParam("id")) && $A.util.isUndefinedOrNull(c.get('v.recordId'))){

        }
    }
})