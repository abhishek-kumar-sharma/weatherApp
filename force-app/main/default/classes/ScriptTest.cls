/*
 * ########################################################################
 * Class Name - ScriptTest
 * Purpose - Class to complete script test given by Akshay sir
 * Date - 03-April-2018
 * Writer Name - Abhishek Kumar Sharma
 * #######################################################################
 * Methods -
 * #######################################################################
 * 1 - LeadTestScript()
 * Param - no parameter
 * Return type - void
 * scope - static
 * visiblity - public
 * Description - create and convert the Leads from starting of the
 * year to today
 * ########################################################################
 * 2 - ConvertingLead()
 * Param - List<Lead>
 * Return type - Set<Id>
 * scope - static
 * visiblity - public
 * Description - Convert Lead
 * ########################################################################
 */


public class ScriptTest {

    public static void LeadTestScript()
        {
            /*
			  * List to store Newly created leads
			  */
            List<lead> nonConvertingleadList = new List<lead>();
            /*
			  * Lead List to store the converting list with status = 'Working - Contacted'
			  */
            List<Lead> convertingLeadList = new List<Lead>();

            /*
			  * Calculating no of days from 01-01-2018 to today
			  */
            date currentDate = System.today();
            Date startDate = Date.newInstance(currentDate.year(),1,1);
            Integer numberOfDays = startDate.daysBetween(currentDate);
            System.debug('NO of days ----> '+numberOfDays);

            //Temp variable to store start date to change account name after lead convert
            Date TempStartDate = startDate;
            Date TempStartDate1 = startDate;

            /*
			  * Creating lead (no of created leads == no of days )
			  */
            for(Integer i=0;i<numberOfDays;i++)
                {
                    Lead leadObject = new Lead();
                    leadObject.LastName = 'CA-Lead- '+startDate.month()+' '+startDate.day()+' '+startDate.year();
                    leadObject.Company = 'CA-Company- '+startDate.month()+' '+startDate.day()+' '+startDate.year();

                    /*
						* Finding status value on given date
						*/
                    Integer dateSum = startDate.month()+startDate.day()+startDate.year();
                    if(Math.mod(dateSum,2) == 0)
                    {
                        leadObject.Status = 'Working - Contacted';
                        //Adding lead to convertingLeadList for conversion
                        convertingLeadList.add(leadObject);
                        System.debug('-------------> Even value '+dateSum);
                    }
                    else
                    {
                        leadObject.Status = 'Open - Not Contacted';
                        nonConvertingleadList.add(leadObject);
                        System.debug('-------------->Odd value '+dateSum);
                    }
                    /*
						* Adding next day
						*/
                    startDate = startDate.addDays(1);
                    System.debug('Next date in Lead creating loop  ----> '+startDate);
                    System.debug('Lead Object final value ----> '+leadObject);

                }
            try
            {
                if(nonConvertingleadList.size() > 0 )
                {
                    /*Inserting the lead record list */
                    Database.SaveResult[] resultListNonConverting = Database.insert(nonConvertingleadList, false);
                    System.debug('resultList -----> '+resultListNonConverting);

                    /* Changing the non converting inserted lead company name */
                    for(Lead leadObjectInstance : nonConvertingleadList)
                        {
                            leadObjectInstance.Company = 'CA-Waste-'+TempStartDate1.month()+' '+TempStartDate1.day()+' '+TempStartDate1.year();
                            TempStartDate1 = TempStartDate1.addDays(1);
                            leadObjectInstance.LeadSource = 'Purchased List';
                        }
                    try
                    {
                        update nonConvertingleadList;
                    }
                    catch(Exception de)
                    {
                        System.debug('Exception occurred while upserting the nonConvertingleadList-----------> Cause-----> '+de.getCause()+'');
                    }

                }
                else
                {
                    System.debug('nonConvertingleadList List Empty');
                    System.debug('Empty nonConvertingleadList List ---------------> '+nonConvertingleadList);
                }
                if(convertingLeadList.size() > 0)
                {
                    /*Inserting the lead record list */
                    Database.SaveResult[] resultListConverting = Database.insert(convertingLeadList, false);
                    System.debug('resultList -----> '+resultListConverting);


                    /* Calling Lead conversion method */
                    Set<Id> returnedAccountIdSet = new Set<Id>();
                    returnedAccountIdSet = ConvertingLead(convertingLeadList);
                    System.debug('returnedAccountIdSet------------------------> '+returnedAccountIdSet);

                    if(returnedAccountIdSet.size() > 0)
                    {
                        /*Getting the newly created Account from lead conversion */
                        List<Account> leadCreatedAccountList = new List<Account>();
                        leadCreatedAccountList = [select Name from Account where Id =: returnedAccountIdSet];
                        /* Changing the name of Account */
                        if(leadCreatedAccountList.size() > 0)
                        {
                            for(Account accountInstance : leadCreatedAccountList)
                                {
                                    accountInstance.Name = 'CA-Account-'+TempStartDate.month()+' '+TempStartDate.day()+' '+TempStartDate.year();
                                    TempStartDate = TempStartDate.addDays(1);
                                }
                            try
                            {
                                update leadCreatedAccountList;
                            }
                            catch(Exception de)
                            {
                                System.debug('Exception occurred while upserting Account Name ----> Cause -----> '+de.getCause()+' Message -----> '+de.getMessage());
                            }

                        }
                        else
                        {
                            System.debug('leadCreatedAccountList Empty ----------> '+leadCreatedAccountList);
                        }

                    }
                    else
                    {
                        System.debug('returnedAccountIdSet is empty');
                    }

                }
                else
                {
                    System.debug('convertingLeadList List Empty');
                    System.debug('Empty convertingLeadList List ---------------> '+convertingLeadList);
                }
            }
            catch(DMLException de)
            {
                System.debug('Exception occurred while inserting the lead ------------->>>> Cause ------>'+de.getCause()+' Message  ----------->>> '+de.getMessage());
            }

        }

    /*Method to convert Lead */
    public static Set<Id> ConvertingLead(List<Lead> leadList)
        {
            /* Getting the label for converted list*/
            LeadStatus convertedLeadStatus= [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true Limit 1];
            System.debug('convertedLeadStatus Label -------> '+convertedLeadStatus);
            /*List to store leads which are going to convert */
            List<Database.LeadConvert> MassLeadconvertList = new List<Database.LeadConvert>();
            for(Lead currentleadInstance: leadList)
                {
                    Database.LeadConvert Leadconvert = new Database.LeadConvert();
                    Leadconvert.setLeadId(currentleadInstance.Id);
                    Leadconvert.setConvertedStatus(convertedLeadStatus.MasterLabel);
                    //Leadconvert.setDoNotCreateOpportunity(TRUE);
                    MassLeadconvertList.add(Leadconvert);
                    System.debug('Leadconvert -------> '+Leadconvert);
                }

            if (!MassLeadconvertList.isEmpty())
            {
                /* Converting Leads and store result for getting account id*/
                List<Database.LeadConvertResult> lcrList = Database.convertLead(MassLeadconvertList);
                System.debug('LeadConvertResult -------> '+lcrList);
                /*Set to store AccountId created while converting the leads */
                Set<Id> accountIdSet = new Set<Id>();
                for(Database.LeadConvertResult leadConvertResultInstance : lcrList)
                    {
                        accountIdSet.add(leadConvertResultInstance.getAccountId());
                        System.debug('Converted Account Id ------------> '+leadConvertResultInstance.getAccountId());

                    }
                System.debug('Converted Account Id set ------>'+accountIdSet);
                return accountIdSet;
            }
            return null;
        }
}