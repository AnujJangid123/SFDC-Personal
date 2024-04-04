trigger B5PanCheck on Application__c (before insert) {
List<application__c> app=trigger.new;
list<blacklist__c> blk=[Select name, Name__c,Pancard__c,Phone__c from Blacklist__c];
    list<blacklist__c> b2=new list<blackList__c>();
    for(application__c a:app){
  
        for(blacklist__c b:blk){
            if(b.pancard__c == a.PANCARD__c && b.Phone__c!=a.Phone__c){
                a.adderror('Applicant Is Blacklisted');
                b.phone__c=a.Phone__c;
              b2.add(b);
            }
        }
            
        } 
    update b2;
}