trigger LeadTrigger1 on Lead (before insert, before update, after update) {
    for(Lead ld:trigger.new){
        if(String.isBlank(ld.LeadSource)){
            ld.LeadSource = 'Other';
        }
        if(String.isBlank(ld.Industry) && Trigger.isInsert){
            ld.addError('The industry field cannot be blank');
        }
    }
    System.debug('Lead Trigger 1 Executed');
}