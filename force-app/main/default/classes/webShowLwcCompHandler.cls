public with sharing class webShowLwcCompHandler {
    @AuraEnabled(cacheable=true)
    public static List<Product2> getProducts() {
        // Retrieve product records from your Salesforce org
        // Replace Product__c with your actual object name
        return [SELECT Id, Name, ProductCode FROM Product2];
    }
}