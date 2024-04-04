public class ActConCreateVfCtrl {
    public Contact con{get;set;}
    public Account acc{get;set;}
    
    public ActConCreateVfCtrl(){
        con = new Contact();
        acc = new Account();
    }
 
    public void saveValues()
    {
        Account acc = new Account();
        acc.Name = con.FirstName + ' ' + con.LastName;
        acc.Phone = con.Phone;
        insert acc;
        Contact con1 = new Contact();
        con1.LastName = con.LastName;
        con1.FirstName = con.FirstName;
        con1.AccountId = acc.Id;
        con1.Email = con.Email;
        //con1.Phone = con.Phone;
        insert con1;
        
        
    }
     public void saveAccount()
    {
        insert acc;
        acc = new Account();
    }
    
    public void saveContact()
    {
        insert con;
        con = new Contact();
    }
 
}