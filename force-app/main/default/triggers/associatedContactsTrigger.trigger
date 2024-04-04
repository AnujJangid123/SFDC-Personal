trigger associatedContactsTrigger on Contact (before insert,before update ,after insert,after update,after delete) {
    if(trigger.isInsert||trigger.isUpdate){
    associatedContactsHandler.getNoOfAssociatedContacts(trigger.new,trigger.old);
    }
}