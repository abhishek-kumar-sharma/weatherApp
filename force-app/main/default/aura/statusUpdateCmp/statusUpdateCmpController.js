/**
 * Created by ABHISHEK on 23-07-2019.
 */
({
    /**
     * Method to check the login details inputted by user
     */
    checkLoginDetails : function (c,e,h) {
        console.log('hello ');
        console.log('username ==> ',c.get("v.username"));
        console.log('password ==> ',c.get("v.password"));
    }
})