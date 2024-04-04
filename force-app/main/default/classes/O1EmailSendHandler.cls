public class O1EmailSendHandler {
    public static void sendEmailNotification(List<Contact> conList){
        list<Messaging.Email> emailList = new List<Messaging.Email>();
        
        for(Contact con : conList){
            if(con.Email !=null){
                Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage();
                String[] toAddress = new String[]{con.Email};
                    emailMsg.setToAddresses(toAddress);
                String emailSub = 'Welcome '+ con.FirstName;
                emailMsg.setSubject(emailSub);
                String disName = 'Anuj Jangid';
                emailMsg.setSenderDisplayName(disName);
                String content = 'Hi' + con.FirstName + ',<br/><br/>'+
                    'Welcome to Salesforce Ecosystem! <br/><br/>'+
                    'Begin your Salesforce Admin and Develop Journey <br/><br/>'+
                    'Happy Learning! <br/><br/>';
                
                emailMsg.setHtmlBody(content);
                emailList.add(emailMsg);
                
            }
        }
        Messaging.sendEmail(emailList);
    }
}