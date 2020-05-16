/**
 * Created by ABHISHEK on 11/21/2018.
 */
({
    changeValueController : function (c) {
        c.set('v.parentValue','Modified value of parent in parent cmp');
        c.set('v.child1Value','Modified value of child1 in parent cmp');
        c.set('v.child2Value','Modified value of child2 in parent cmp');
        c.set("v.loadchild",true);
    }
})