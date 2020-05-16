trigger AudrunoTrigger on Testing_Aurduno_Heat_2_2_1__e (after insert) {
    System.debug('Trigger.New'+Trigger.New);
    System.debug('Trigger.Old'+Trigger.Old);
}