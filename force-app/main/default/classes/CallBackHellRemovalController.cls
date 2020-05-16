/*
 * Created by Abhishek Kumar Sharma on 9/2/2018.
 * To send back the account,opportunity,opportunity line item and product details
 */
public class CallBackHellRemovalController {

	/*
	 * Method to get account id
	 */
	@AuraEnabled
	public static List<Account> getAccounts_Apex() {
		List<Account> accountList = new List<Account>();
		accountList = [SELECT ID,NAME FROM Account ];
		if (accountList.size() > 0) {
			System.debug('accountList ->' + accountList);
			Integer start = System.Now().millisecond();
			while(System.Now().millisecond()< start+50){
			}
			return accountList;
		}
		return null;
	}

	/*
	 * Method to get opportunity details on basic of account id
	 */
	@AuraEnabled
	public static List<Opportunity> getOpportunityOnBasicOfAccountId_Apex(List<Account> accountList) {
		System.debug('accountListaccountList --> ' + accountList);
		Set<Id> accountIdSet = new Set<Id>();
		for (Account accObject : accountList)
			{
				accountIdSet.add(accObject.Id);
			}
		List<Opportunity> opportunityList = new List<Opportunity>();
		opportunityList = [SELECT id,Name,accountId from Opportunity where accountId =: accountIdSet];
		System.debug('opportunityList ->' + opportunityList);
		if (opportunityList.size() > 0) {
			Integer start = System.Now().millisecond();
			while(System.Now().millisecond()< start+50){
			}
			return opportunityList;
		}

		return null;
	}

	/*
	 * Method to get opportunity line item details on basic of opportunity
	 */
	@AuraEnabled
	public static List<OpportunityLineItem> getOppotunityLineItemOnBasicOfOpportunityId_Apex(
			List<Opportunity> opportunityList) {
		System.debug('opportunityListopportunityListopportunityList -> ' + opportunityList);
		Set<Id> opportunityIdSet = new Set<Id>();
		for (Opportunity opportunityObject : opportunityList)
			{
				opportunityIdSet.add(opportunityObject.Id);
			}
		List<OpportunityLineItem> opportunityLineItemList = new List<OpportunityLineItem>();
		opportunityLineItemList =
		[SELECT name,opportunityId,product2Id from OpportunityLineItem where opportunityId =: opportunityIdSet];
		System.debug('opportunityLineItemList ->' + opportunityLineItemList);
		if (opportunityLineItemList.size() > 0) {
			Integer start = System.Now().millisecond();
			while(System.Now().millisecond()< start+100){
			}
			return opportunityLineItemList;
		}

		return null;
	}

	/*
	 * Method to get product details on basic of opportunity line item
	 */
	@AuraEnabled
	public static List<Product2> getProductDetailsOnBasicOfOpportunityLineItem_Apex(List<OpportunityLineItem> oliList) {
		Set<Id> productIdSet = new Set<Id>();
		for (OpportunityLineItem oliObject : oliList)
			{
				productIdSet.add(oliObject.Product2Id);
			}
		List<Product2> product2List = new List<Product2>();
		product2List = [SELECT ID,NAME,IsActive,CreatedBy.Name FROM Product2 where id =: productIdSet];
		System.debug('product2List ->' + product2List);
		if (product2List.size() > 0) {
			Integer start = System.Now().millisecond();
			while(System.Now().millisecond()< start+70){
			}
			return product2List;
		}
		return null;
	}

}