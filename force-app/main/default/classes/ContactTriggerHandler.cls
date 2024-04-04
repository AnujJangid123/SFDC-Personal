public class ContactTriggerHandler {

    public static void only5Contacts(List<Contact> conList) {
        Set<Id> accIds = new Set<Id>();
        Map<Id, Integer> accountContactCount = new Map<Id, Integer>();

        for (Contact con : conList) {
            if (con.AccountId != null) {
                accIds.add(con.AccountId);
            }
        }

        for (AggregateResult result : [SELECT AccountId, COUNT(Id) cnt FROM Contact WHERE AccountId IN :accIds GROUP BY AccountId]) {
            accountContactCount.put((Id)result.get('AccountId'), (Integer)result.get('cnt'));
        }

        for (Contact con : conList) {
            if (con.AccountId != null) {
                Integer conCount = accountContactCount.get(con.AccountId);
                if (conCount == null) {
                    conCount = 0;
                }
                
                if (conCount >= 3) {
                    con.addError('Max 3 Contacts allowed');
                }
                else if(conCount <3){
                    conCount++;
                    accountContactCount.put(con.AccountId, conCount);
                }
            }
        }
    }
}