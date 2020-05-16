/**
 * Created by ABHISHEK on 11/20/2018.
 */
({
    loadValueChildOne : function (c,e,h) {
        c.set("v.parentValue",'Parent value changed in child one component');
        c.set('v.childOneValue',"Child one value changed in child one method");
        c.set('v.childTwoValue',"child two value changed in child one method");
    }

})