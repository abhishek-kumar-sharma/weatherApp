public class testhello {
private final Account user_Acc;
    public testhello(ApexPages.StandardController stdCtrl){
        this.user_Acc = (Account)stdCtrl.getRecord();
    }
    public String getGreeting() {
        return 'Hello ';
    }
    public static void helloWorld(){
        System.debug('Hello world called');
    }
}