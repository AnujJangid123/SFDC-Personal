public class SOQL {
    public static void main()
    {
        list<Account> accList = [Select Id,Name from Account];
        
         for(Integer i=0;i<5;i++)
        {
         system.debug(acclist);
        }
    }
}