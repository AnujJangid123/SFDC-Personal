trigger lightningUploadTrigger on ContentVersion (before insert) {
    System.debug('Trigger List-->'+trigger.new[0]);
    trigger.new[0].Title=trigger.new[0].Title.substring(0,trigger.new[0].Title.length()-4);

}