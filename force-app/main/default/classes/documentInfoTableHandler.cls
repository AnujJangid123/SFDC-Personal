public with sharing class documentInfoTableHandler {
    @AuraEnabled(cacheable = true)
    public static List<Required_Documents__c> getDataInfo(){
        List<Required_Documents__c> docList =[Select Id,Document_Number__c,Document_Title__c,
        Document_Description__c FROM Required_Documents__c order by Document_Number__c asc  limit 10];
        return docList;
    }
}