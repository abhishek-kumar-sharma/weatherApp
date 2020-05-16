/*trigger on Case to create another case with subject "THIS Case is closed"+ old Case Subject 
and all the other fields as well whenver a case is getting closed with Account Name "Ajay".*/

trigger CaseTriggerForAjayAccount on Case (after update, before insert) {
    CreateAnotherCaseHandler.createCase(Trigger.new);
    
}