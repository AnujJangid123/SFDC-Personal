public with sharing class practiceLWCCompHandler {
    @AuraEnabled(cacheable=true)
    public static List<String> getObjectNames() {
        List<String> objectNames = new List<String>();
        
        for (Schema.SObjectType objType : Schema.getGlobalDescribe().values()) {
            objectNames.add(objType.getDescribe().getName());
        }
        
        return objectNames;
    }

    // @AuraEnabled(cacheable=true)
    // public static List<String> getObjectFields(String objectName) {
    //     List<String> fieldNames = new List<String>();
        
    //     for (Schema.SObjectField field : Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap().values()) {
    //         fieldNames.add(field.getDescribe().getName());
    //     }
        
    //     return fieldNames;
    // }

     @AuraEnabled
    public static void saveAccountRecord(Account objAcc){
        try{
            insert objAcc;
        }
        catch(Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<String> getObjectFields(String objectName) {
    List<String> fieldNames = new List<String>();
    Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
    for (String fieldName : fieldMap.keySet()) {
        Schema.DescribeFieldResult fieldDescribe = fieldMap.get(fieldName).getDescribe();
        String fieldInfo = fieldDescribe.getLabel() + ',' + fieldDescribe.getName() + '@@@@' + fieldDescribe.getType();
        fieldNames.add(fieldInfo);
    }
    return fieldNames;
}

    
}