public class SubmitCaseController {
	
	public Case c { get; set; }
	
	public String acctNum { get; set; }
	
	public SubmitCaseController() {
		c = new Case();
	}
	
	public PageReference submitCase() {
		List<Account> acc = [SELECT Id FROM Account WHERE AccountNumber = :acctNum];
		if (acc.size() != 1) {
			ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.FATAL, 'Invalid account number');
			ApexPages.addMessage(msg);
			return null;
		} else {
			try {
				c.AccountId = acc.get(0).Id;
				
				
				Contact cnt = [SELECT Id FROM Contact WHERE AccountId = :c.AccountId AND Email = :c.SuppliedEmail LIMIT 1];
				if (cnt != null) 
					c.ContactId = cnt.Id;
					
				Database.DMLOptions dmlOpts = new Database.DMLOptions();
				dmlOpts.assignmentRuleHeader.useDefaultRule = true;
				c.setOptions(dmlOpts);

				
				INSERT c;
				return new PageReference('/thanks');
			} catch (Exception e) {
				ApexPages.addMessages(e);
				return null;
			}
		}
	}
}