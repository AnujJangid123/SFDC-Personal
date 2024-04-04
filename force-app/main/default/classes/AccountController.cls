public with sharing class AccountController {
    @AuraEnabled
    public static List<Contact> getContactDataWithFieldSet(String fieldSetName) {

        List<Contact> contacts = [SELECT  FirstName, LastName, Account.Name, Account.Industry FROM Contact];

       

        return contacts;
    }


    @AuraEnabled
    public static List<Map<String, Object>> returnColumns(String fieldSetName){



        
        List<Map<String, Object>> columnsData = new List<Map<String, Object>>();
        SObjectType contactType = Schema.getGlobalDescribe().get('Contact');
        Schema.DescribeSObjectResult contactDescribe = contactType.getDescribe();
        Schema.FieldSet fieldSet = contactDescribe.fieldSets.getMap().get(fieldSetName);

        if (fieldSet != null) {
            for (Schema.FieldSetMember field : fieldSet.getFields()) {
                Map<String, Object> column = new Map<String, Object>();
                column.put('label', field.getLabel());
                column.put('fieldName', field.getFieldPath());
                column.put('type', 'text');
                columnsData.add(column);
            }
        }
        
        return columnsData;
    }

    public class ContactWrapper {
        @AuraEnabled public Contact contactRecord { get; set; }
        @AuraEnabled public String accountName { get; set; }
        @AuraEnabled public String accountIndustry { get; set; }
    }
}