import { LightningElement, track } from 'lwc';
import getAccountList_Apex from '@salesforce/apex/testGetAccount.getAccountList';
import getOpportunityList_Apex from '@salesforce/apex/testGetAccount.getOpportunityFromAccountId';

export default class AccountWithRelatedOpp extends LightningElement {
    @track accountList;
    @track showAccount = false;
    @track showOpportunity = false;
    @track opportunityList = {};
    connectedCallback(){
        this.getAccount();
    }

    getAccount() {
        try{
            getAccountList_Apex()
            .then(value => {
                console.log('Fetched account :::',value);
                this.accountList = value;
                this.showAccount = true;
            })
        }catch(e){
            console.error('Error while getting the Account records. \n Message : ',e.message);
            
        }
    }

    showRelatedOpportunity(event){
        // console.log('event ===>',event.detail);
        // console.log('event access key===>',event.accesskey);
        // console.log('event access target key===>',event.target.accesskey);
        // console.log('event access class key===>',event.target.class);
        // console.log('event access name key===>',event.target.name);
        // console.log('event access id key===>',event.target.id);
        console.log('event access id key===>',event.currentTarget.id);
        getOpportunityList_Apex({
            "accountId" : event.currentTarget.id
        })
        .then(value => {
            console.log('returned oppo ::',value);
            this.opportunityList = value;
            this.showOpportunity = true;
        })
    }
} 