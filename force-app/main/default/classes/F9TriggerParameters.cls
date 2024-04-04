/*March 2015 - James Scott
*
*   Purpose:  This class keeps tracks of all the trigger context variabls and adds a few things so that 
*             these elements can be easily referenced from all apex code when in the context a trigger.
*             This class is always instantiated from F9TriggerFactory which is called as the single line
*             of all triggers that have been migrated to the trigger framework.
*             
*   Test Classes:  UnitTests_TriggerFramework
*
*
*   Change log
*     Author            Date            Description
* ========================================================================================================
*   JamesScott         Sep 2020         Added firstObject, triggerOrdinalObjMap, and triggerObjectCallCount 
*                                       for performance tracking and to allow invoked triggers to determine 
*                                       the initiating object.
*/

public class F9TriggerParameters {

	public Enum TriggerEvent {beforeInsert, beforeUpdate, beforeDelete, afterInsert, afterUpdate, afterDelete, afterUndelete }
	public TriggerEvent tEvent;
	public string strEvent;
	public List<SObject> oldList {get; private set; }
	public List<SObject> newList {get; private set; }
	public Map<Id, SObject> oldMap {get; private set; }
	public Map<Id, SObject> newMap {get; private set; }
	public String triggerObject {get; private set; } 
	public Boolean isExecuting {get; private set; }
    public static string firstObject {get; private set; }
    public static string firstEvent {get; private set; }
    // map ordinal to object
    public static map<integer,string> triggerOrdinalObjMap {get; private set; }
    //map of object to iteration count
    public static map<string,integer> triggerObjectCallCount {get; private set; }

	/** 
	* @description Constructs the TriggerParameter object.
	* @param List<SObject> A list of records with the state of 'before' event.
	* @param List<SObject> A list of records with the state of 'after' event.
	* @param Map<Id, SObject> A map of records with the state of 'before' event.
	* @param Map<Id, SObject> A map of records with the state of 'after' event. 
	* @param Boolean A flag to indicate 'isBefore' event.
	* @param Boolean A flag to indicate 'isAfter' event.
	* @param Boolean A flag to indicate 'isDelete' event.
	* @param Boolean A flag to indicate 'isInsert' event.
	* @param Boolean A flag to indicate 'isUpdate' event.
	* @param Boolean A flag to indicate 'isUnDelete' event.
	* @param Boolean A flag to indicate 'isExecuting'.
	*/
	public F9TriggerParameters(List<SObject> olist, List<SObject> nlist, Map<Id, SObject> omap, Map<Id, SObject> nmap,
								Boolean ib, Boolean ia, Boolean id, Boolean ii, Boolean iu, Boolean iud, Boolean ie) {
		this.oldList = olist;
		this.newList = nlist;
		this.oldMap = omap;
		this.newMap = nmap;
		this.triggerObject = UtilityClass.getSObjectTypeName((this.oldList != null && this.oldList.size() > 0) ? this.oldList[0] : this.newList[0]);
        if(firstObject == null){
            firstObject= this.triggerObject;
        }
        
        if(triggerOrdinalObjMap == null){
        	triggerOrdinalObjMap = new map<integer,string>();
            triggerObjectCallCount = new map<string,integer>();  
        }
        integer ordinalCnt = triggerOrdinalObjMap.size();
        triggerOrdinalObjMap.put(++ordinalCnt, this.triggerObject);
        
        integer objCnt = 0;
      	if(triggerObjectCallCount.containsKey(this.triggerObject)){
            objCnt = triggerObjectCallCount.get(this.triggerObject);
        }
        triggerObjectCallCount.put(this.triggerObject, ++objCnt);
                                                                        
		if (ib & ii) tEvent = TriggerEvent.beforeInsert;
		else if (ib && iu) tEvent = TriggerEvent.beforeUpdate;
		else if (ib && id) tEvent = TriggerEvent.beforeDelete;
		else if (ia && ii) tEvent = TriggerEvent.afterInsert;
		else if (ia && iu) tEvent = TriggerEvent.afterUpdate;
		else if (ia && id) tEvent = TriggerEvent.afterDelete;
		else if (ia && iud) tEvent = TriggerEvent.afterUndelete;
		isExecuting = ie;
		strEvent = string.valueOf(tEvent);
        
        if(firstEvent == null){
            firstEvent = this.strEvent;
        }
	}
}