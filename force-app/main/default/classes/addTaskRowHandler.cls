public with sharing class addTaskRowHandler {
    public addTaskRowHandler(){

    }
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(String actName) {
        List<Account> accountList = new List<Account>();
        if(actName!=''){
            String accountName = '%' + actName + '%';
            accountList = [select id,name from Account where name like:accountName];
        }
        else{
            accountList = [select id,name from Account LIMIT 10];
        }
        return accountList;
    }

    @AuraEnabled
    public static List<Account> getAccount() {
        
        
        return [select id,name from Account LIMIT 10];
        
    }
    
}