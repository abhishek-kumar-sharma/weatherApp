public with sharing class SendEmailHandler {
	public static void sendEmail(List<Contact> conList)
	{
		if(conList.size() > 0 )
		{
			/*Fetching the owner Id of the contact*/
			Set<Id> ownerId = new Set<Id>();
			for(Contact conTemp : conList)
			{
				ownerId.add(conTemp.OwnerId);
			}
			
			/*Fetching Owner Email Id from User*/
		    String ownerEmailList = [select Email from User where Id IN:ownerId].Email;
						
			/*Creating String of CC and To addresses */
			List<String> ccAddress = new List<string>();
			List<String> toAddress = new List<String>();
			for(Contact conTemp : conList)
			{
				ccAddress.add(conTemp.Email);
				toAddress.add(ownerEmailList);	  
			}
			
			
			/*Creating and adding object to Messaging.SingleSendEmail List for storing the multiple email*/
			List<Messaging.SingleEmailMessage> singleSendMessageList = new List<Messaging.SingleEmailMessage>();
			for(Contact conTemp : conlist)
			{
				/*Adding email information to SingleSendMessaging object*/
				Messaging.SingleEmailMessage singleSendMessageObj = new Messaging.SingleEmailMessage();
				singleSendMessageObj.setSubject('Alert ! '+conTemp.FirstName+' '+conTemp.LastName);
				singleSendMessageObj.setCcAddresses(ccAddress);
				singleSendMessageObj.setToAddresses(toAddress);
				String body = 'A new contact is inserted in Salesforce and contact Name '+conTemp.FirstName +' '+conTemp.LastName+' Mobile Number of contact is '+conTemp.MobilePhone+' Mailing Address of contact is '
				+conTemp.MailingStreet+''+conTemp.MailingCity+''+conTemp.MailingState+''+conTemp.MailingCountry+''+conTemp.MailingPostalCode;
				singleSendMessageObj.setPlainTextBody(body);
				singleSendMessageObj.setEmailPriority('High');
				singleSendMessageList.add(singleSendMessageObj);
								
			}  
			
			/*Sending emai via using Messaging.sendEmail()*/
			Messaging.SendEmailResult [] result = Messaging.sendEmail(singleSendMessageList);
			
			System.debug('-----------> '+result);
			
			
		}
		else
		{
			System.debug('---------------->Null Contact List recieved <----------------');
		}
	}
    
}