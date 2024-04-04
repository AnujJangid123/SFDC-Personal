public with sharing class AccountContactCreationController {

    @AuraEnabled
    public static void submitForm(String firstName, String lastName, String email, String companyName, String phone, String userName) {
        
        System.debug('firstnName is--->'+firstName);
        System.debug('lastName is--->'+lastName);
        System.debug('email is--->'+email);
        System.debug('companyName is--->'+companyName);
        System.debug('phone is--->'+phone);
        Messaging.SingleEmailMessage emailMessage = new Messaging.SingleEmailMessage();

        // Set the recipients (To address)
        emailMessage.setToAddresses(new String[]{'custom_inbound_mail@22crpwt47mruvegqj3j64gl1w0uiboi47po06em8p218eia6w6.2w-qtcbleaz.ap16.apex.salesforce.com'});

        // Set the subject of the email
        emailMessage.setSubject('Contact Form Submission');

        // Set the body of the email (you can use HTML for formatting)
        String emailBody = '' + firstName + '@@@'
                            + lastName + '@@@'
                            + email + '@@@'
                            + companyName + '@@@'
                            + phone + '@@@'
                            + userName + '@@@';
        emailMessage.setPlainTextBody(emailBody);

        // Optionally, you can set the sender display name and email address
        // emailMessage.setSenderDisplayName('Sender Name');
        // emailMessage.setReplyTo('sender@example.com');

        // Send the email
        List<Messaging.SendEmailResult> sendResults = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{emailMessage});

        // Check if the email was sent successfully
        if (sendResults[0].isSuccess()) {
            
        } else {
            System.debug('Error sending email: ' + sendResults[0].getErrors()[0].getMessage());
            // Handle error scenario here
        }
        
    }

}