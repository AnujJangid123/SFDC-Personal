public class AccountHandler {
    //Q.O5 Write a trigger on Account , when an account insert , automatically account billing address should populate into the account shipping address.
    public static void BillToShip(list<Account> newlist){
        for(Account acc : newlist){
			acc.ShippingState = acc.BillingState;
			acc.ShippingStreet = acc.BillingStreet;
			acc.ShippingCountry = acc.BillingCountry;
			acc.ShippingCity = acc.BillingCity;
				}
    		}
    
    //Q.B3 When a new  Account is inserted  with Industry as banking  assign the owner as  'karthic'
    public static void KarthicWithBanking(list<Account> newlist){
            User u=[select id from User where username = 'karthic@gmail.com'];
    		for(Account acc:newlist){
        	if(acc.Industry == 'Banking'){
           	acc.OwnerId = u.id;
        		}
    		   }
   			 }
    
    //Q.B4 When ever new Account is inserted with industry as Energy and Type as new Customer then create new Opportunity with same account data.
    public static void IndustryAsEnergy(list<Account> newlist){
            list<Opportunity> Opplist = new list<Opportunity>();
    		for(Account acc: newlist){
        	if(acc.Industry == 'Energy' && acc.Type == 'Customer - Direct'){
            	Opportunity opp = new Opportunity();
            	opp.AccountId=acc.Id;
            	opp.Name=acc.Name;
            	opp.StageName= 'Need Analysis';
            	opp.CloseDate=Date.Today();
            	OppList.add(opp);
            	insert OppList;
        		}
    		   }
    		  }
    
    //Q.B1 When a new Account is inserted with Industry as Banking  then set the annual revenue as 50000.
    public static void IndustryAsBanking(list<Account> newlist){
            for(Account acc: newlist){
        		if(acc.Industry == 'Banking'){
            	acc.AnnualRevenue = 50000;
        		}
    		   }
    		  }

	//Q.O10 "Create a field on Account Named (Client Contact lookup to Contact)Once an account insert a contact 
	//will create with the name of account and that contact will be the client contact on Account"   
    public static void ClientContact (list<Account> newlist){
         List<Contact> conList = new List<Contact>();
    	 List<Account> accList = new List<Account>();
    		for(Account acc : newlist) {
        	conList.add(new Contact(LastName = acc.Name,
            AccountId = acc.Id));
    		}
    		if(conList.size() > 0) {
        	insert conList;
    	   }
    		for(Contact con : conList) {
        		Account acc = [SELECT Id, Name, Client_Contact__c  FROM Account WHERE Id =: con.AccountId];
        		acc.Client_Contact__c  = con.Id;
        		accList.add(acc);
   			    }
    		update accList;
    	   }
    
    //Q.O12 "Once an account an email should go to the admin user with specified text below.An account has been created and name is ""Account Name""."
    public static void MailToAdmin(list<Account> newlist){
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
		User userObj=[select Id,Profile.Name,Email from user where Profile.Name='System Administrator'];   
    
    	for(Account acc: newlist){
        	if(userObj.Email !=null){
            	
			Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
			message.toAddresses = new String[] {userObj.Email};
			message.subject = 'Account Created';
			message.plainTextBody = 'An account has been created and the name is.'+userObj.Email;
			Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage>{message};
         	Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
    		 }
       		}
       	   }
    
    //Q.O10 When  a new Account record is inserted check wheather any duplicate Account exists based on Account Name,Industry  if duplicate record found throw error message
    public static void DupRecord(list<Account> newlist){
        
        
        
    		}
    
    
    
    
    public static void AddUserToAccountTeamMember(list<Account> acct){
        list<AccountTeamMember> atm=new list<AccountTeamMember>();
        user newuser=[select id,name from user where name='karthic'];
        for(Account accts:acct){
            if(accts.Industry=='Banking' && accts.AnnualRevenue>500000){
                AccountTeamMember acctm=new AccountTeamMember();
                acctm.AccountId=accts.Id;
                acctm.UserId=newuser.Id;
                atm.add(acctm);
            }
        }
        if(atm.size()>0){
            insert atm;
        }
        
    }

	//formula
	public static void updateFormula(List<Account>TriggerNew){
		for(Account acc:TriggerNew){
			acc.name = 'test1';
			update acc;
		}
	}
}