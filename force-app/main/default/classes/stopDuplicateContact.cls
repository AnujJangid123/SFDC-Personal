public class stopDuplicateContact { 
    public static void noDuplicateContact(list<Contact> conlist){
       	set<id> newId = new set<id>();
        set<String> newRec = new set<String>();
        for(Contact con : conList){
            newId.add(con.AccountId);
        }
        
        if(newId.size()>0){
            for(Contact con : [select FirstName,LastName,AccountId from Contact where AccountId IN:newId]){
                String Concat = String.valueOf(con.FirstName).toLowerCase().trim() + con.LastName + con.AccountId;
                newRec.add(Concat);
            }
        }
        
        if(newRec.size()>0){
            for(Contact con:conList){
                string concat = con.FirstName + con.LastName + con.AccountId;
                if(newRec != null && newRec.contains(concat)){
                    con.addError('This contact already exists');
                }
            }
        }
    }
}