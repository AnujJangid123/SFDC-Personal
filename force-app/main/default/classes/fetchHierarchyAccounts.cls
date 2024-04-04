public class fetchHierarchyAccounts {
    public static List<Account> fetchChildAccounts(Id parentAccId) {
        List<Account> allChilds = new List<Account>();
        Set<Id> parentIds = new Set<Id>{parentAccId};
        Account[] children;
        do {
            children = [SELECT Id, Name, ParentId FROM Account WHERE ParentId IN :parentIds];
            allChilds.addAll(children);
            parentIds.clear();
            for (Account child : children) {
                parentIds.add(child.Id);
            }
        } while (children.size() > 0);
        system.debug('Accounts fetched--->'+allChilds);
        return allChilds;
    }
}