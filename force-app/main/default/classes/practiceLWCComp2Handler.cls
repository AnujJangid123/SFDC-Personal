public with sharing class practiceLWCComp2Handler {
    @AuraEnabled(cacheable=true)
    public static List<String> getObjectNames() {
        List<String> objectNames = new List<String>();
        for (Schema.SObjectType objType : Schema.getGlobalDescribe().Values()) {
            Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
            if (objDescribe.isQueryable() && !objDescribe.isDeprecatedAndHidden()) {
                objectNames.add(objDescribe.getName());
            }
        }
        objectNames.sort();
        return objectNames;
    }

    // @AuraEnabled(cacheable=true)
    // public static List<String> getObjectFields(String objectNames) {
    //     List<String> fieldNames = new List<String>();
    //     Schema.SObjectType objType = Schema.getGlobalDescribe().get(objectNames);
    //     if (objType != null) {
    //         Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
    //         for (Schema.SObjectField field : objDescribe.fields.getMap().values()) {
    //             fieldNames.add(field.getDescribe().getName());
    //         }
    //     }
    //     return fieldNames;
    // }
}