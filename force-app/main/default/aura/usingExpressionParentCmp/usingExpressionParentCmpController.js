/**
 * Created by ABHISHEK on 11/20/2018.
 */
({
    loadValue : function (c,e,h) {
        c.set("v.parentValue",'Parent Attribute value loaded from Parent controller');
        c.set("v.childOneValue",'Child one value loaded from parent component');
        c.set("v.childTwoValue",'Child two value loaded from parent component');
        c.set("v.loadTwo",true);
    },
    choiceSelect : function (c) {
        c.set("v.choice",!c.get("v.choice"));
    }

})