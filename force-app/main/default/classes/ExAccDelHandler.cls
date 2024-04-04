public class ExAccDelHandler {
    public static void ExAccDel(list <Account> accList){
        
        Set<string> accNewName = new set<string>();
        Map<string, List<Contact>> accNameWiseContacts = new Map<string, List<Contact>>();
        List<Account> accToDelete = new List<Account>();
        List<Contact> contactsToTransfer = new List<Contact>();
        for(Account acc:accList){
            accNewName.add(acc.Name);
            system.debug('Account--->'+acc.Name);
        }
        if(accNewName.size()>0){
            for(account acc:[Select Id, Name,(select ID from Contacts) from Account where Name in:accNewName]){
                if(!accNameWiseContacts.containsKey(acc.Name)){
                    accNameWiseContacts.put(acc.Name, new List<contact>());
                    system.debug('Map---> '+accNameWiseContacts);
                }
                if(acc.Contacts.size()>0){
                    accNameWiseContacts.get(acc.Name).addAll(acc.Contacts);
                    system.debug('Map---> '+accNameWiseContacts);
                    
                    accToDelete.add(acc);
                }
            }
        }
        if(accNameWiseContacts.size()>0){
            system.debug('MAp---> '+accNameWiseContacts);

            
            for(account acc: accList){
                if(accNameWiseContacts.containsKey(acc.Name)){
                    system.debug('MAp---> '+accNameWiseContacts);
                    
                    for(Contact con:accNameWiseContacts.get(acc.Name)){
                        system.debug('Contacts--->'+con);
                        con.AccountId= acc.ID;
                        contactsToTransfer.add(con);
                    }
                }
            }
        }
        if(contactsToTransfer.size()>0){
            system.debug('Contacts--->'+contactsToTransfer);
            update contactsToTransfer;
            delete accToDelete;
        }
    }
	}