trigger O3DupConCheck on Contact (before insert) {
        
    /*	Set <String> emailSet = new Set<String>(); 
    
    	Set <String> phoneSet = new Set<String>(); 
    
        for (contact con:trigger.new) {
        emailSet.add(con.email);
        phoneSet.add(con.phone);
    }


    List <Contact> contactList = new List<Contact>();

    contactlist = [SELECT email,phone FROM Contact WHERE email IN :emailSet OR phone IN :phoneSet];
    
    for (contact con:trigger.new) {
        If (contactList.size() > 0) {
            con.email.adderror( 'Account already exists.' );
        }
        }*/
}