@isTest
public class HelloWorldTest {

    @isTest static void updateLead(){
        Lead myLead = new Lead();
        myLead.FirstName = 'David';
        myLead.LastName = 'Liu';
        myLead.Company = 'Google';
        insert myLead;
        
        myLead.Company = 'PluralSight';
        update myLead;
    }
}