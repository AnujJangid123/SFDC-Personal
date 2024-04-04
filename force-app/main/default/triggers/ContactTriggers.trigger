trigger ContactTriggers on Contact (before insert) {
//if(Trigger.isInsert || Trigger.isUpdate){
  //      if(trigger.isBefore){
        //ContactHandler.ErrorOnNoAcc(trigger.new);
        //DupConCheckHandler.DupConCheck(trigger.new);
      //  }
    //    if(trigger.isAfter){
        //ContactHandler.sendEmailNotification(trigger.new);
     //   }
  //  }
  //stopDuplicateContact.noDuplicateContact(trigger.new);
    ContactTriggerHandler.only5Contacts(trigger.new);
}