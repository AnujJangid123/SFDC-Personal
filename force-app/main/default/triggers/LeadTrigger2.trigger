trigger LeadTrigger2 on Lead (before insert, before update) {
       for(Lead ld:trigger.new){
        if(String.isBlank(ld.Rating)){
            ld.Rating = 'Warm';
        }
    }
    System.debug('Lead trigger 2 is executing');
}