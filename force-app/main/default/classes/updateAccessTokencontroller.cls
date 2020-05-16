public with sharing class updateAccessTokencontroller {
	 public ECSV__Tracxn_Access_Token__c accessToken{get; set;}
    
    /* Constructor */
    public updateAccessTokencontroller(){
        //Initialize new custom setting record
        this.accessToken = new ECSV__Tracxn_Access_Token__c();
    }
    
    //Insert the new custom setting record in the database
    public PageReference saveRecord(){
        insert this.accessToken;
        //Redirect to new record detail page
        return new PageReference('/' + this.accessToken.Id);
    }
}