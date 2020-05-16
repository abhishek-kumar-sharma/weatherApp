/*Trigger on account to create a default Contact, Case, Opporunity and Contact Role.
 whenever an Account is created with Number of Employees > 100.
  Make sure the Contact is in contact field of Case as well as related to Opporutnity inn Contact Role.
  
  Written by Abhishek Kumar sharma
  date 29-01-2018*/
trigger TestProgram16 on Account (after insert, before update) {
    CreateCaseHandler.createCase(Trigger.new);
    
}