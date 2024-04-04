public with sharing class fetchRecordWrapper {
    @AuraEnabled
    public List<Contact> contacts { get; set; }
    
    @AuraEnabled
    public List<Map<String, Object>> dynamicColumns { get; set; }
}