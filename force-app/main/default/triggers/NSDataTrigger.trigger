trigger NSDataTrigger on NS_Data__c (before insert,before update) {
    if(Trigger.isInsert || Trigger.isUpdate){
        NSDataHandler.OfferingDataFetch(trigger.new);
    }
}