global with sharing class ProductControllerClass {
    @AuraEnabled(cacheable=true)
    global static List<Product2> getProducts() {
        return [SELECT Id, Name, ProductCode, Family, Description FROM Product2];
        
    }
}