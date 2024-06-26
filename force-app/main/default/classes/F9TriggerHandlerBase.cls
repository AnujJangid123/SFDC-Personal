/**
* @description This class implements the ITriggerHandler to provide abstract/virtual methods for the interface methods
*				and so that the trigger handlers need to implement only the method that they have to. The only exception
*				is the mainEntry, which is mandatory for the trigger handlers to implement.
*/
public abstract class F9TriggerHandlerBase implements IF9TriggerHandler {
	protected Map<Id, SObject> sObjectsToUpdate = new Map<Id, SObject>();
	
	/** 
	* @description Called for the first time in the execution context. The trigger handlers need to implement
	*				this method.
	* @param TriggerParameters The trigger parameters such as the list of records before and after the update.
	*/
	public abstract void mainEntry(F9TriggerParameters tp);
	
	/** 
	* @description Called for the subsequent times in the same execution context. The trigger handlers can chose
	*				to ignore if they don't need the reentrant feature.
	* @param TriggerParameters The trigger parameters such as the list of records before and after the update.
	*/
	public virtual void inProgressEntry(F9TriggerParameters tp) {
		
	}
	/** 
	* @description Updates the objects, if any.
	*/
	public virtual void updateObjects() {
		if(sObjectsToUpdate.size() > 0)
			update sObjectsToUpdate.values();
	}
}