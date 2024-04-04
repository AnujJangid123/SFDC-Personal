trigger O1ConEmailSend on Contact (after insert){
    if(Trigger.isInsert && Trigger.isAfter){
        O1EmailSendHandler.sendEmailNotification(trigger.new);
    }
}