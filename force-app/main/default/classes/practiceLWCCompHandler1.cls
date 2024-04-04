public with sharing class practiceLWCCompHandler1 {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getAllOpportunities() {
        return [SELECT Name, CreatedBy.Name, CloseDate, CreatedDate FROM Opportunity];
    }
}