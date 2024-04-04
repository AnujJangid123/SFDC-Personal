public with sharing class CreateFramworkTestRec {
	
	static map<string, FrameWorkTest__c> fwtMap = new map<string, FrameWorkTest__c>();
	public FrameWorkTest__c fwt;
	static integer createOrdinal = 1;
	
	public CreateFramworkTestRec(string className, string objName, string tEvent){
		
		//checkExistingFWTRec(className, objName, tEvent);
		string mapKey = className + objName + tEvent;
		if(!fwtMap.containsKey(mapKey)){ 
			fwt = fwtMap.get(mapKey);
		}
		if(fwt == null){
			fwt = new FrameWorkTest__c();
		}
		
		fwt.name = className;
		fwt.Initiating_Object__c = objName;
		fwt.Handler_Event__c = tEvent;
		fwt.Handler_Ordinal__c = createOrdinal++;
		fwt.Iterations__c = fwt.Iterations__c == null ? 1: fwt.Iterations__c++;
		
		System.Debug(LOGGINGLEVEL.INFO,'Create FWT: ' + className + ' ' + objName + ' ' + tEvent);
		
		upsert fwt;
		
		fwtMap.put(mapKey, fwt);

	}

}