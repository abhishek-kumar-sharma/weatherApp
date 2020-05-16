/*
 * Class to handle BulkOpportunityTrigger
 */
public class BulkOpportunityOrderHandler {

	/*
	 * Mehtod to create order
	 */
	public static void createOpportunityOrder(map<Id, Opportunity> newMap, map<Id, Opportunity> oldMap)
		{
			System.debug('Received New opportunity map from trigger ---> ' + newMap);
			System.debug('Received old opportunity map from trigger ---> ' + oldMap);

			Set<Id> opportunityIdSet = new Set<Id>();
			for (Id opportunityId : newMap.keySet())
				{
					if (newMap.get(opportunityId).StageName == 'Send Order' &&
									oldMap.get(opportunityId).StageName != 'Send Order' &&
									newMap.get(opportunityId).HasOpportunityLineItem == true)
					{
						opportunityIdSet.add(opportunityId);
					}
				}
			System.debug('Opportunity Id Set -----------> ' + opportunityIdSet);

			if (opportunityIdSet.size() > 0)
			{
				/*
				 * Fetching Opportunity Line Item via opportunityIdSet
				 */
				List<OpportunityLineItem> opportunityLineItemList = new List<OpportunityLineItem>();
				opportunityLineItemList =
				[select Id,Name,OpportunityId,PricebookEntryId,Product2Id,Quantity,UnitPrice from opportunityLineItem where OpportunityId IN: opportunityIdSet ];
				System.debug('Opportunity Line item List ----> ' + opportunityLineItemList);
				if (opportunityLineItemList.size() > 0)
				{
					/*
					 * Map of opportunity Id and Opportunity Line Items
					 */
					map<Id, List<OpportunityLineItem>> opportunityIdVsOLIMap = new map<Id, List<OpportunityLineItem>>();
					for (OpportunityLineItem oliInstance : opportunityLineItemList)
						{
							if (!opportunityIdVsOLIMap.containsKey(oliInstance.OpportunityId))
							{
								opportunityIdVsOLIMap.put(oliInstance.OpportunityId, new List<OpportunityLineItem>());
							}
							opportunityIdVsOLIMap.get(oliInstance.OpportunityId).add(oliInstance);
						}
					System.debug('Map of Opportunity Id and Opportunity Line Item ---> ' + opportunityIdVsOLIMap);

					/*
					 * Creating temporary account for adding in contract and order if opportunity have no account
					 */
					Account orderAccount = new Account();
					orderAccount.Name = 'Order Account';
					try
					{
						insert orderAccount;
					} catch (DmlException dmlException)
					{
						System.debug('DMl Exception occurred while inserting Account ----> cause -----> ' +
								dmlException.getCause() + ' Message ----- >' + dmlException.getMessage());
					}

					/*Contract for creating order */
					Contract contractObject = new Contract();
					contractObject.AccountId = orderAccount.Id;
					contractObject.Status = 'Draft';
					contractObject.StartDate = System.today();
					contractObject.ContractTerm = 2;
					try
					{

					}
					catch (DmlException dmlException)
					{
						System.debug('DmlException occurred while inserting contract -----> Cause -----> '+dmlException.getCause()+' Message  ----> '+dmlException.getMessage());
					}

					/* Creating order list */
					List<Order> orderList = new List<Order>();
					for(Id opportunityIdInstance : opportunityIdSet)
						{
							Order orderObject = new Order();
							orderObject.AccountId = orderAccount.Id;
							orderObject.ContractId = contractObject.Id;
							orderObject.OpportunityId = opportunityIdInstance;
							orderObject.EffectiveDate = System.today();
							orderList.add(orderObject);
						}
					try
					{
						insert orderList;
					}
					catch (DmlException dmlException)
					{
						System.debug('Exception Occurred while inserting the order list ----> Cause ----> '+dmlException.getCause()+' Message ----> '+dmlException.getMessage());
					}
					/* Creating orderItem list*/
					List<OrderItem> orderItemList = new List<OrderItem>();
					for (Id opportunityInsatnce : opportunityIdVsOLIMap.keySet())
						{
							OrderItem orderItem = new  OrderItem();

						}


				} else
				{
					System.debug('Null opportunity line item list received -------> ' + opportunityLineItemList);
				}
			} else
			{
				System.debug('Unable to get value of opportunityId null opportunity set ----> ' + opportunityIdSet);
			}
		}

	/*
	 * Method to check stage Name not equal to send order at opportunity creation time
	 */
	public static void checkStageNameBeforeInsert(List<Opportunity> oppList)
		{
			for (Opportunity oppInstance : oppList)
				{
					if (oppInstance.StageName == 'Send Order')
					{
						oppInstance.addError('Unable to create opportunity with send order stage ');
					}
				}
		}

}