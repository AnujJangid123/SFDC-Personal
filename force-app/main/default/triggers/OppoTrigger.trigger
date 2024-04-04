trigger OppoTrigger on Opportunity (before insert,before update){//,after insert, before update, after update, before delete) {
   // if(trigger.isInsert || trigger.isUpdate)
    //{
    //testTrigger1Handler.getAssociatedOpportunity(trigger.new,trigger.old);
    OppoTriggerHandler.billToAccToOpp(trigger.new);
    //}
}