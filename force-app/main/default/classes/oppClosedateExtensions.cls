public class oppClosedateExtensions {
    private final Opportunity opTemp;
    public oppClosedateExtensions(ApexPages.StandardController stdController){
        this.opTemp = (Opportunity)stdController.getRecord();
        Opportunity opp = [select CloseDate from Opportunity where Id = :opTemp.Id limit 1];
        if(opp.CloseDate < date.today()+5){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Your Close date is near!!!!'));
        }
    }
}