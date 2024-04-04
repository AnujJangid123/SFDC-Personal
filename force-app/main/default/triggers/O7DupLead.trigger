trigger O7DupLead on Lead (before insert, after insert) {
    	
    	List<Lead> leads = new list<Lead>();
    
        List<Lead> leadIDs = new List<Lead>();

        for(Lead ld : leads){
            leadIDs.add(ld);
        }

       List<Lead> cloned = leadIDs.Clone();
       System.debug('Cloned '+ cloned);
}