public with sharing class OpportunityController {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> searchOpportunities(String searchTerm) {
        // Implement your logic to search for opportunities here
        // You can use SOQL queries or any custom logic
        // For example:
        String searchQuery = '%' + searchTerm + '%';
        return [SELECT Id, Name FROM Opportunity WHERE Name LIKE :searchQuery LIMIT 10];
    }
}