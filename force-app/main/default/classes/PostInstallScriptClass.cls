/**
* Created by ABHISHEK KUMAR SHARM on 05-02-2020.
*/

global without sharing class PostInstallScriptClass implements InstallHandler {
    global void onInstall(InstallContext installContext) {
        /* Account accountInstance = new Account();
         accountInstance.Name = 'Abhishek New Script Account';
         String informationToPush;
         informationToPush = 'org id : ' + installContext.organizationId();
         informationToPush = informationToPush + ' installed id :: ' + installContext.installerId();
         informationToPush = informationToPush + ' is upgrade  :: ' + installContext.isUpgrade();
         informationToPush = informationToPush + ' is push  :: ' + installContext.isPush();
         informationToPush = informationToPush + ' is previous version   :: ' + installContext.previousVersion();
         accountInstance.Description = informationToPush;

         List<PermissionSet> permissionList = [SELECT Profile.id,Profile.Name FROM PermissionSet WHERE IsOwnedByProfile = TRUE AND Id IN (SELECT ParentId FROM ObjectPermissions WHERE PermissionsRead = TRUE AND PermissionsEdit = FALSE AND SObjectType = 'Account') ORDER BY Profile.Name];
         System.debug('permissionList ::' + permissionList);
         accountInstance.Description = accountInstance.Description + 'permissionList ::' + permissionList;
         List<PermissionSet> permissionListRW = [SELECT Profile.id,Profile.Name FROM PermissionSet WHERE Id IN (SELECT ParentId FROM ObjectPermissions WHERE PermissionsRead = TRUE AND PermissionsEdit = TRUE AND SObjectType = 'ECSV__Doctor__c') ORDER BY Profile.Name];
         System.debug('permissionListRW ::' + permissionListRW);
         accountInstance.Description = accountInstance.Description + 'permissionListRW ::' + permissionListRW;
         set<id> profileIdSetRead = New Set<id>();
         set<id> profileIdSetReadWrite = New Set<id>();
         for (PermissionSet ps : permissionList) {
             profileIdSetRead.add(ps.Profile.id);
         }
         for (PermissionSet ps : permissionListRW) {
             profileIdSetReadWrite.add(ps.Profile.id);
         }
         List<user> userListRead = [select id,ProfileId from user where ProfileId In:profileIdSetRead and IsActive = True];
         System.debug('userListRead ::' + userListRead);
         accountInstance.Description = accountInstance.Description + 'userListRead ::' + userListRead;
         List<user> userListReadWrite = [select id,ProfileId from user where ProfileId In:profileIdSetReadWrite and IsActive = True];
         System.debug('userListReadWrite ::' + userListReadWrite);
         accountInstance.Description = accountInstance.Description + 'userListReadWrite ::' + userListReadWrite;

         List<PermissionSet> permissionSetListRead = [SELECT ID FROM PermissionSet where name = 'Test_Read' limit 1];
         List<PermissionSet> permissionSetListReadWrite = [SELECT ID FROM PermissionSet where name = 'Test_Read_Write' limit 1];

         List<PermissionSetAssignment> permissionSetAssignmentsList = new List<PermissionSetAssignment>();
         for (user user : userListRead) {
             PermissionSetAssignment psa = new PermissionSetAssignment(PermissionSetId = permissionSetListRead[0].id, AssigneeId = user.id);
             permissionSetAssignmentsList.add(psa);
         }
         for (user user : userListReadWrite) {
             PermissionSetAssignment psa = new PermissionSetAssignment(PermissionSetId = permissionSetListReadWrite[0].id, AssigneeId = user.id);
             permissionSetAssignmentsList.add(psa);
         }
         System.debug('Befoe insert ' + permissionSetAssignmentsList);
         accountInstance.Description = accountInstance.Description + 'permissionSetAssignmentsList ::' + permissionSetAssignmentsList;
         insert accountInstance;
         //insert permissionSetAssignmentsList;

         Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
         string[] to = new string[]{
                 'abhishek.ksharma@cloudanalogy.com'
         };

         email.setToAddresses(to);
         email.setSubject('Test Mail');
         email.setPlainTextBody(String.valueOf(accountInstance));
         // Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
         System.debug('After insert ' + permissionSetAssignmentsList);*/
        /*try {
            set<id> userIdSetRead = new set<id>();
            set<id> userIdSetRW = new set<id>();
            List<PermissionSetAssignment> permissionSetAssignmentListRead = [
                    SELECT Assignee.id, PermissionSet.Id, PermissionSet.isOwnedByProfile, PermissionSet.Profile.Name, PermissionSet.Label
                    FROM PermissionSetAssignment
                    WHERE PermissionSet.IsOwnedByProfile = TRUE AND PermissionSetId IN (
                            SELECT ParentId
                            FROM ObjectPermissions
                            WHERE SObjectType = 'ECSV__Doctor__c' AND
                            PermissionsRead = true AND PermissionsEdit = FALSE
                    )
            ];
            List<PermissionSetAssignment> permissionSetAssignmentListRW = [
                    SELECT Assignee.id, PermissionSet.Id, PermissionSet.isOwnedByProfile, PermissionSet.Profile.Name, PermissionSet.Label
                    FROM PermissionSetAssignment
                    WHERE PermissionSet.IsOwnedByProfile = TRUE AND PermissionSetId IN (
                            SELECT ParentId
                            FROM ObjectPermissions
                            WHERE SObjectType = 'ECSV__Doctor__c' AND
                            PermissionsRead = true AND PermissionsEdit = true
                    )
            ];

            for (PermissionSetAssignment psa : permissionSetAssignmentListRead) {
                userIdSetRead.add(psa.Assignee.id);
            }
            for (PermissionSetAssignment psa : permissionSetAssignmentListRW) {
                userIdSetRW.add(psa.Assignee.id);
            }
            List<user> userListRead = [select id,ProfileId from user where id In:userIdSetRead and IsActive = True];
            List<user> userListRW = [select id,ProfileId from user where id In:userIdSetRW and IsActive = True];

            Account ac = new account();
            ac.name = 'post install 3';
            ac.Description = '--->permissionList---->' + String.valueOf(permissionSetAssignmentListRead) + '--->userListRead---->' + String.valueOf(userListRead)+ '--->userListRW---->' + String.valueOf(userListRW) + ' permissionSetAssignmentListRW ===>' + permissionSetAssignmentListRW;

            List<PermissionSet> permissionSetListRead = [SELECT ID FROM PermissionSet where name = 'Test_Read' limit 1];
            List<PermissionSet> permissionSetListReadWrite = [SELECT ID FROM PermissionSet where name = 'Test_Read_Write' limit 1];

            ac.Description += '--->permissionSetListRead---->' + String.valueOf(permissionSetListRead) + 'permissionSetListReadWrite ' + permissionSetListReadWrite;
            List<PermissionSetAssignment> PermissionSetAssignmentInsertList = New list<PermissionSetAssignment>();

            for (user userInstance : userListRead) {
                if (!permissionSetListRead.isEmpty()) {
                    PermissionSetAssignment psa = new PermissionSetAssignment(PermissionSetId = permissionSetListRead[0].id, AssigneeId = userInstance.id);
                    PermissionSetAssignmentInsertList.add(psa);
                    ac.Description += '--->psa---->' + String.valueOf(psa);
                }
            }
            for (user userInstance : userListRW) {
                if (!permissionSetListReadWrite.isEmpty()) {
                    PermissionSetAssignment psa = new PermissionSetAssignment(PermissionSetId = permissionSetListReadWrite[0].id, AssigneeId = userInstance.id);
                    PermissionSetAssignmentInsertList.add(psa);
                    ac.Description += '--->userListRW---->' + String.valueOf(psa);
                }
            }
            insert ac;
            insert PermissionSetAssignmentInsertList;

        } catch (exception e) {
            Account ac = new Account();
            ac.name = 'Post install error';
            ac.Description = String.valueOf(e.getMessage()) + '--->Line number--->' + e.getLineNumber() + ' CAuse ::' + e.getCause();
            insert ac;
            System.debug('Error--->' + e.getMessage());
        }*/
        try {
            List<PermissionSet> permissionListread = [SELECT Profile.id,Profile.Name FROM PermissionSet WHERE IsOwnedByProfile = TRUE AND Id IN (SELECT ParentId FROM ObjectPermissions WHERE PermissionsRead = TRUE AND PermissionsEdit = FALSE AND SObjectType = 'ECSV__Doctor__c') ORDER BY Profile.Name];
            List<PermissionSet> permissionListRW = [SELECT Profile.id,Profile.Name FROM PermissionSet WHERE IsOwnedByProfile = TRUE AND Id IN (SELECT ParentId FROM ObjectPermissions WHERE PermissionsRead = TRUE AND PermissionsEdit = TRUE AND SObjectType = 'ECSV__Doctor__c') ORDER BY Profile.Name];
            Account acc = new Account();
            system.debug('permissionListread : ' + permissionListread);
            acc.Description = acc.Description + 'permissionListread : ' + permissionListread;
            system.debug('permissionListRW : ' + permissionListRW);
            acc.Description = acc.Description + 'permissionListRW : ' + permissionListRW;
            set<id> profileIdSetR = New Set<id>();
            set<id> profileIdSetRW = New Set<id>();

            for (PermissionSet ps : permissionListread) {
                profileIdSetR.add(ps.Profile.id);
            }

            for (PermissionSet ps : permissionListRW) {
                profileIdSetRW.add(ps.Profile.id);
            }

            List<user> userListR = [select id,ProfileId from user where ProfileId = :profileIdSetR and IsActive = True];
            List<user> userListRW = [select id,ProfileId from user where ProfileId = :profileIdSetRW and IsActive = True];
            acc.Description = acc.Description + 'userListR : ' + userListR;
            acc.Description = acc.Description + 'userListRW : ' + userListRW;
            List<PermissionSet> permissionSetListRead = [SELECT ID FROM PermissionSet where name = 'Test_Read' limit 1];
            List<PermissionSet> permissionSetListReadWrite = [SELECT ID FROM PermissionSet where name = 'Test_Read_Write' limit 1];
            acc.Description = acc.Description + 'permissionSetListRead : ' + permissionSetListRead;
            acc.Description = acc.Description + 'permissionSetListReadWrite : ' + permissionSetListReadWrite;
            List<PermissionSetAssignment> psaList = new List<PermissionSetAssignment>();
            acc.Name = 'Hello world new';
            insert acc;
            for (user userInstance : userListR) {
                if (!permissionSetListRead.isEmpty()) {
                    PermissionSetAssignment psa = new PermissionSetAssignment(PermissionSetId = permissionSetListRead[0].id, AssigneeId = userInstance.id);
                    psaList.add(psa);
                    insert psa;
                    //acc.Description = acc.Description +'psa : '+psa;
                    system.debug('psa R ' + psa);
                }
            }

            for (user userInstance : userListRW) {
                if (!permissionSetListReadWrite.isEmpty()) {
                    PermissionSetAssignment psa = new PermissionSetAssignment(PermissionSetId = permissionSetListReadWrite[0].id, AssigneeId = userInstance.id);
                    psaList.add(psa);
                    //acc.Description = acc.Description +'psa RWRW: '+psa;
                    insert psa;
                    system.debug('psa RW ' + psa);
                }
            }

            // insert psaList;
            system.debug('psaList :: ' + psaList);
        } catch (Exception ecxe) {
            Account acc = new Account();
            acc.Name = 'Hello MEssage new';
            acc.Description = 'MEssage :' + ecxe.getMessage() + 'Cause :' + ecxe.getCause();
            insert acc;
            System.debug('MEssage :' + ecxe.getMessage() + 'Cause :' + ecxe.getCause());
        }
    }

}