public class programSelectionController {
   
    @AuraEnabled
    public static list<Offeringg__c> getSchoolYear(){
         
        return [SELECT  School_Year__r.Name FROM Offeringg__c ORDER BY School_Year__r.Name ];
    } 

    @AuraEnabled
    public static list<offeringg__c> getGrade(){
         
        return [SELECT Program__r.Grade__r.Name FROM Offeringg__c ORDER BY Program__r.Grade__r.Name];
    }

    @AuraEnabled
    public static list<offeringg__c> getCampus(){
         
        return [SELECT Campus__r.Name FROM Offeringg__c Order by Campus__r.Name];
    }

    @AuraEnabled
    public static list<offeringg__c> getTime(){
        return [SELECT Program__r.Time__c , Program__r.Time_Slot_Description__c from Offeringg__c order by Program__r.Time__c ];
    }

   
    
}