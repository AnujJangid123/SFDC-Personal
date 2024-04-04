public class demoStaticClass {
    public string personName{get;set;}
    public Integer intValue{get;set;}
    public integer jvalue{get;set;}
    public integer finalValue{get;set;}
    public List<Account> lstAcc{get;set;}
    public demoStaticClass(){
        intValue = 0;
        jvalue = 0;
        finalValue = 0;
        lstAcc = new List<Account>();
    }
    public void sumMethod(){
        finalValue = 10;
        lstAcc = [SELECT id,Name,Phone from Account];
        
    }
    public void subMethod(){
        Integer sum = intValue-jvalue;
        finalValue =  sum;
    }
    public void mulMethod(){
        Integer sum = intValue*jvalue;
        finalValue =  sum;
    }
    public void divMethod(){
        Integer sum = intValue/jvalue;
        finalValue =  sum;
    }
}