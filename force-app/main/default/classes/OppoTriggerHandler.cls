public class OppoTriggerHandler {
    //Opportunity Stage Update to Closed Lost if created date>28 and stage name is not  closed won 
    public static void OppoStageUpdate(list<Account> accList){
        set<ID> accountIds = new set<ID>();
        for(Account a:accList){
            accountIds.add(a.Id);
        }
        DateTime day28=system.now()-28;
        List<Opportunity> oppListToUpdate = new list<Opportunity>();
        List<opportunity> oppList = [select Id, accountid, stagename, createddate,closedate from opportunity where AccountId in :accountIds];
        if(oppList.size()>0){
            for(opportunity opp: opplist){
                if(opp.CreatedDate<day28 && opp.StageName!='closed won'){
                    opp.StageName='Closed Lost';
                    opp.CloseDate=system.today();
                    oppListToupdate.add(opp);
        }
    }
}
        if(opplisttoupdate.size()>0){
            update oppListToUpdate;
        }
    }
    
    // Get no of associated opportunity to account in a field in account object
    public static void getAssociatedOpportunity(list<Opportunity> newList, list<Opportunity> oldList){
        Set<id> accId = new set<id>();
        list<Account> updatedAccount = new list<Account>();
        
        if(newList!=null){
            for(Opportunity opp : newList){
                if(opp.AccountId!=null){
                    accId.add(opp.AccountId);
            }
        }
    }
        
        if(oldList!=null){
            for(Opportunity opp : oldList){
                if(opp.AccountId!=null){
                    accId.add(opp.AccountId);
                	}
                }
            }
        
        
        if(accId.size()>0)
        {
            for(AggregateResult aggRes:[select AccountId accId1,Count(id)OppCount,
                                        Sum(Amount)SumAmt,Max(Amount)MaxAmt,Min(Amount)MinAmt,AVG(Amount)AvgAmt
                                       from Opportunity where AccountId IN:accId GROUP BY AccountId]){
                                           Account acc=new Account();
                                               acc.id=(Id) aggRes.get('accId1');
                                               acc.Sum_of_Opportunity__c =(Double) aggRes.get('SumAmt');
                                               acc.No_of_associated_opportunity__c =(Integer) aggRes.get('OppCount');
                                               acc.Avg_of_Opportunity__c =(Double) aggRes.get('avgAmt');
                                               acc.Min_of_Opportunity__c =(Double) aggRes.get('minAmt');
                                               acc.Max_of_Opportunity__c =(Double) aggRes.get('maxAmt');
                                               updatedAccount.add(acc);
                                        }
            if(updatedAccount.size()>0){
                update updatedAccount;
            }
        }
        }
    
    //To autopopulate value from a field in account to associated opportunity object field
    
    public static void billToAccToOpp(list<opportunity> oppList)
    {
    Set<Id> accIds = new Set<Id>();
    for (Opportunity opp : oppList) {
        accIds.add(opp.AccountId);
    }
    
    Map<Id, Account> accountMap = new Map<Id, Account>([
        SELECT Id, Bill_To_Acc__c FROM Account WHERE Id IN :accIds]);
    
    for (Opportunity opp : opplist) {
        if (accountMap.containsKey(opp.AccountId)) {
            Account acc = accountMap.get(opp.AccountId);
            opp.Bill_To_Account__c  = acc.Bill_To_Acc__c ;
        }
    }
 
    }
}