public class EncryptExtensioncls{
    public ECSV__Login__c encrypt{get;set;}
    //Blob cryptoKey;
    Blob cryptoKey = Blob.valueOf('380db410e8b11fa9');
    public Id recordId{get;set;}
    public EncryptExtensioncls(ApexPages.StandardController controller) {
        //cryptoKey = Crypto.generateAesKey(256);
        recordId = Apexpages.CurrentPage().getParameters().get('id');
        if(recordId !=null){
            encrypt = [SELECT id,ECSV__User_Name__c From ECSV__Login__c 
                    WHERE id=:recordId];
        }
        else{
            encrypt = new ECSV__Login__c();
        }
    }
    
    public PageReference Save(){
         
         Blob data = Blob.valueOf(encrypt.ECSV__User_Name__c);
         Blob encryptedData = Crypto.encryptWithManagedIV('AES128', cryptoKey , data );
         String b64Data = EncodingUtil.base64Encode(encryptedData);
         encrypt.ECSV__User_Name__c = b64Data ;
         
         insert encrypt;
         return null; 
    }
    public PageReference test(){
         
         //Blob cryptoKey = Crypto.generateAesKey(256);
         //Blob data = Blob.valueOf(encrypt.Name);
         Blob data = EncodingUtil.base64Decode(encrypt.ECSV__User_Name__c);
         Blob decryptedData = Crypto.decryptWithManagedIV('AES128', cryptoKey , data);
         String dryptData = decryptedData.toString();
         System.debug('Printing dryptData '+dryptData);
         
         encrypt.ECSV__User_Name__c = dryptData;
         
         update encrypt;
         return null; 
    }
}