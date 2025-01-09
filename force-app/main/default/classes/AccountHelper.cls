public class AccountHelper {
  //Retrieve all the objects from org
    @AuraEnabled (cacheable=true)
    public static List<EntityDefinition> retreieveObjects(){
        return [SELECT Id, MasterLabel,  
                    DeveloperName, 
                    QualifiedApiName 
                    FROM EntityDefinition 
                    WHERE IsApexTriggerable = true
                    ORDER BY MasterLabel];
    }

    //Retrieve field details based on Object API Name
    @AuraEnabled (cacheable=true)
    public static String getListOfFields(String objectAPIName){
        Map<string, string> fieldList = new Map<string, string>();
        if(!String.isEmpty(objectAPIName)){
            Map<String, String> mapField = new Map<String, String>();
            Map<string,SObjectField> lstFields = 
                schema.getGlobalDescribe().get(objectAPIName).getDescribe().fields.getMap();

            for(String str: lstFields.keySet()){
                mapField.put(str, lstFields.get(str).getDescribe().getLabel());                
            }
            System.debug(JSON.serializePretty(mapField));
            return JSON.serializePretty(mapField);
        }
        return null;
    }

    //Retrieve records based on selected fields and object.
    @AuraEnabled (cacheable=true)
    public static List<SObject> retreieveRecords(String objectName, String fieldAPINames){
        String strQuery = 'SELECT ' + String.escapeSingleQuotes(fieldAPINames) 
                        + ' FROM ' 
                        + String.escapeSingleQuotes(objectName) 
                        + ' LIMIT 20';
        return database.query(strQuery);
    }
    @AuraEnabled(cacheable=true)
    public static List<account>  getAccountList(){
        return [SELECT Id, Name,Phone,Industry FROM Account order by createddate desc LIMIT 5];
    }
	
    public static void avoidDuplicateName(F9TriggerParameters tp){
        Set<String> setOfNames = new Set<String>();
        Set<String> SetOfExistingNames = new Set<String>();
        for(Account acc: (list<Account>)tp.newList){
            setOfNames.add(acc.Name);
        }
        if(setOfNames.size() >0){
            for(Account acc: [Select id, Name from Account where Name IN: setOfNames]){
                SetOfExistingNames.add(acc.Name);
            }
        }
        for(Account acc: (list<Account>)tp.newList){
            if(SetOfExistingNames.contains(acc.Name)){
                acc.addError('Duplicate Name Exists !');
            }
        }
    }
    
}