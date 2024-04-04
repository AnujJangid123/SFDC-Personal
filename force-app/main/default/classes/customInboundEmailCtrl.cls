@TestVisible
global class customInboundEmailCtrl implements Messaging.InboundEmailHandler {
    @TestVisible
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        String inputString= email.subject;
        String reser= email.plainTextBody;
        Account acc = new Account();
        acc.Name = reser.split('@@@')[3];
        acc.Phone = reser.split('@@@')[4];
        insert acc;
        Contact con = new Contact();
        con.FirstName = reser.split('@@@')[0];
        con.LastName = reser.split('@@@')[1];
        con.Phone = reser.split('@@@')[4];
        con.Email = reser.split('@@@')[2];
        con.AccountId = acc.Id;
        insert con;
        user usr = new user();
        usr.FirstName = reser.split('@@@')[0];
        usr.LastName = reser.split('@@@')[1];
        usr.Phone = reser.split('@@@')[4];
        usr.CompanyName = reser.split('@@@')[3];
        usr.Email = reser.split('@@@')[2];
        usr.Username = reser.split('@@@')[5];
        insert usr;
        result.success = true;
        System.debug(result);
        return result;
    }
}