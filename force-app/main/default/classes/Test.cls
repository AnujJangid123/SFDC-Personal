public class Test {
    public Contact con{get;set;}
    
    
    public Test(){
        con = new Contact();
    }
    public void saveContact()
    {
        insert con;
        con = new Contact();
        //JAI SHREE RAM
    }
}