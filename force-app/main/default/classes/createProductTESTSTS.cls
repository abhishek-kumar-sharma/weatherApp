/**
 * Created by ABHISHEK KUMAR SHARM on 08-02-2020.
 */
@isTest
public with sharing class createProductTESTSTS {
    static testMethod void testInstallScript(){
        Test.startTest();
        createProduct.createProduct();
        Test.stopTest();
    }
}