public class associatedContactsHandler {
    public static void getNoOfAssociatedContacts(list<Contact> newList,list<Contact> oldList){
        Set<Id> accId=new Set<Id>();
        List<Account> updatedAccount=new List<Account>();
        if(newList!=null){
            for(Contact con:newList){
                if(con.AccountId!=null){
                    accId.add(con.AccountId);
                }
            }
            
        }
        if(oldList!=null){
            for(Contact con:oldList){
                if(con.AccountId!=null){
                    accId.add(con.AccountId);
                }
            }  
        }
        if(accId.Size()>0){
            for(AggregateResult aggResult:[Select AccountId accId1,Count(id)ConCount
                                           from Contact where AccountId IN:accId GROUP BY AccountId]){
                                               Account acc=new Account();
                                               acc.id=(Id) aggResult.get('accId1');
                                               acc.No_of_associated_contacts__c =(Integer) aggResult.get('ConCount');
                                               updatedAccount.add(acc);
                                           }
            if(updatedAccount.Size()>0){
                update updatedAccount;
            }
        }

}   
}