public class NSDataHandler {
    public static void OfferingDataFetch(list<NS_Data__c> newlist)
    {
        set<String> sYear = new set<String>();
        set<String> camp = new set<String>();
        set<String> prog = new set<String>();
        map<string, offering__c> mapOfValuesConcatenateWiseOffering = new map<string, offering__c>();
        
        for(NS_Data__c nsData : newlist)
        {
            sYear.add(nsData.School_Year__c );
            camp.add(nsData.Campus__c );
            prog.add(nsData.Program__c);
        }
        
        if(sYear.size()>0 && camp.size()>0 && prog.size()>0)
        {
            for(Offering__c off:[select Id,School_Year__c,Campus__c,Program__c from Offering__c
                                 where School_Year__c IN:sYear and Campus__c IN:camp and
                                 Program__c IN:prog])
             {                       
              	String offeringConcatenate = off.Campus__c+'@@'+off.School_Year__c+'@@'+off.Program__c;
              	mapOfValuesConcatenateWiseOffering.put(offeringConcatenate,off);                 
             }
            
        }
            for(NS_Data__c nsData : newlist)
            {
              String nsDataConcatenate = nsData.Campus__c+'@@'+nsData.School_Year__c+'@@'+nsData.Program__c;
                if(mapOfValuesConcatenateWiseOffering.containsKey(nsDataConcatenate))
                {
                    nsData.Offering__c = mapOfValuesConcatenateWiseOffering.get(nsDataConcatenate).ID;
                    
                }
                    
            }
	}
}