/**
* @description This factory creates the correct dispatcher and dispatches the trigger event(s) to the appropriate 
*				event handler(s). The dispatchers are automatically created using the Type API, hence dispatcher 
*				registration is not required for each dispatchers.
*/
public with sharing class F9TriggerFactory {
    /** 
	* @description Creates the appropriate dispatcher and dispatches the trigger event to the dispatcher's event handler method.
	* @param Schema.sObjectType Object type to process (SObject.sObjectType)
	*/
    public static void createTriggerDispatcher(Schema.sObjectType soType)
    {
        IF9TriggerDispatcher dispatcher = getTriggerDispatcher(soType); 
        if (dispatcher == null){
        	System.Debug(LOGGINGLEVEL.INFO, '1. Dispatcher Name: ' + dispatcher);
        	dispatcher = getTriggerDispatcherShortName(soType);
        }
        System.Debug(LOGGINGLEVEL.INFO, '2. Dispatcher Name: ' + dispatcher);
        if(dispatcher == null){
        	dispatcher = getTriggerDispatcherShortNameNoUnderScores(soType);
        }
        System.Debug(LOGGINGLEVEL.INFO, '3. Dispatcher Name: ' + dispatcher);
        if (dispatcher == null){
            throw new F9TriggerException('No Trigger dispatcher registered for Object Type: ' + soType);
        }
        System.Debug(LOGGINGLEVEL.INFO, 'Dispatcher Name: ' + dispatcher);
        execute(dispatcher);
    }

    /** 
	* @description Dispatches to the dispatcher's event handlers.
	* @param IF9TriggerDispatcher A Trigger dispatcher that dispatches to the appropriate handlers
	*/ 
    private static void execute(IF9TriggerDispatcher dispatcher)
    {
    	F9TriggerParameters tp = new F9TriggerParameters(Trigger.old, Trigger.new, Trigger.oldMap, Trigger.newMap,
									Trigger.isBefore, Trigger.isAfter, Trigger.isDelete, 
									Trigger.isInsert, Trigger.isUpdate, Trigger.isUnDelete, Trigger.isExecuting);
        // Handle before trigger events
        if (Trigger.isBefore) {
            dispatcher.bulkBefore();
            if (Trigger.isDelete) 
                dispatcher.beforeDelete(tp);
            else if (Trigger.isInsert)
                dispatcher.beforeInsert(tp);
            else if (Trigger.isUpdate)
                dispatcher.beforeUpdate(tp);      
        }
        else	// Handle after trigger events
        {
           dispatcher.bulkAfter();
            if (Trigger.isDelete)
                dispatcher.afterDelete(tp);
            else if (Trigger.isInsert)
                dispatcher.afterInsert(tp);
            else if (Trigger.isUpdate)
                dispatcher.afterUpdate(tp);
            else if (Trigger.isUnDelete)
                dispatcher.afterUnDelete(tp);
        }
       // dispatcher.andFinally();
    } 

    /** 
	* @description Gets the appropriate dispatcher based on the SObject. It constructs the instance of the dispatcher
	*				dynamically using the Type API. The name of the dispatcher has to follow this format:
	*				<ObjectName>TriggerDispatcher. For e.g. for the Feedback__c object, the dispatcher has to be named
	*				as FeedbackTriggerDispatcher.
	* @param Schema.sObjectType Object type to create the dispatcher
	* @return IF9TriggerDispatcher A trigger dispatcher  if one exists or null.
	*/
    private static IF9TriggerDispatcher getTriggerDispatcher(Schema.sObjectType soType)
    {
    	String originalTypeName = soType.getDescribe().getName();
    	String dispatcherTypeName = null;
    	if (originalTypeName.toLowerCase().endsWith('__c')) {
    		Integer index = originalTypeName.toLowerCase().indexOf('__c');
    		dispatcherTypeName = originalTypeName.substring(0, index) + 'TriggerDispatcher';
    	}
    	else
    		dispatcherTypeName = originalTypeName + 'TriggerDispatcher';
		//for managed package namespace qualifiers
		if(dispatcherTypeName.contains('__')){
			dispatcherTypeName = dispatcherTypeName.remove('__');
		}
		
		Type obType = Type.forName(dispatcherTypeName);
		IF9TriggerDispatcher dispatcher = (obType == null) ? null : (IF9TriggerDispatcher)obType.newInstance();
    	return dispatcher;
    }
    //for objects that will make the dispatcher name longer than 40 characters, use the short name.
    private static IF9TriggerDispatcher getTriggerDispatcherShortName(Schema.sObjectType soType)
    {
    	String originalTypeName = soType.getDescribe().getName();
    	
    	String dispatcherTypeName = null;
    	if (originalTypeName.toLowerCase().endsWith('__c')) {
    		Integer index = originalTypeName.toLowerCase().indexOf('__c');
    		dispatcherTypeName = originalTypeName.substring(0, index) + 'TrDisp';
    		System.Debug(LOGGINGLEVEL.INFO, 'Searching for short name1a: ' + dispatcherTypeName);
    	}
    	else{
    		dispatcherTypeName = originalTypeName + 'TrDisp';
    		System.Debug(LOGGINGLEVEL.INFO, 'Searching for short name1b: ' + dispatcherTypeName);
    	}
    	System.Debug(LOGGINGLEVEL.INFO, 'Searching for short name2: ' + dispatcherTypeName);
		//for managed package namespace qualifiers
		if(dispatcherTypeName.contains('__')){
			dispatcherTypeName = dispatcherTypeName.remove('__');
			System.Debug(LOGGINGLEVEL.INFO, 'Searching for short name2b: ' + dispatcherTypeName);
		}
		System.Debug(LOGGINGLEVEL.INFO, 'Searching for short name3: ' + dispatcherTypeName);
		Type obType = Type.forName(dispatcherTypeName);
		IF9TriggerDispatcher dispatcher = (obType == null) ? null : (IF9TriggerDispatcher)obType.newInstance();
    	return dispatcher;
    }
    private static IF9TriggerDispatcher getTriggerDispatcherShortNameNoUnderScores(Schema.sObjectType soType)
    {
    	String originalTypeName = soType.getDescribe().getName();
    	
    	String dispatcherTypeName = null;
    	if (originalTypeName.toLowerCase().endsWith('__c')) {
    		Integer index = originalTypeName.toLowerCase().indexOf('__c');
    		dispatcherTypeName = originalTypeName.substring(0, index) + 'TrDisp';
    		System.Debug(LOGGINGLEVEL.INFO, '3. Searching for short name1a: ' + dispatcherTypeName);
    	}
    	else{
    		dispatcherTypeName = originalTypeName + 'TrDisp';
    		System.Debug(LOGGINGLEVEL.INFO, '3. Searching for short name1b: ' + dispatcherTypeName);
    	}
    	System.Debug(LOGGINGLEVEL.INFO, '3. Searching for short name2: ' + dispatcherTypeName);
		//for managed package namespace qualifiers
		if(dispatcherTypeName.contains('_')){
			dispatcherTypeName = dispatcherTypeName.remove('_');
			System.Debug(LOGGINGLEVEL.INFO, '3. Searching for short name2b: ' + dispatcherTypeName);
		}
		System.Debug(LOGGINGLEVEL.INFO, '3. Searching for short name3: ' + dispatcherTypeName);
		Type obType = Type.forName(dispatcherTypeName);
		IF9TriggerDispatcher dispatcher = (obType == null) ? null : (IF9TriggerDispatcher)obType.newInstance();
    	return dispatcher;
    }
    private static IF9TriggerDispatcher getTriggerDispatcherMgdPkg(Schema.sObjectType soType)
    {
    	String originalTypeName = soType.getDescribe().getName();
    	String dispatcherTypeName = null;
    	if (originalTypeName.toLowerCase().endsWith('__c')) {
    		Integer index = originalTypeName.toLowerCase().indexOf('__c');
    		dispatcherTypeName = originalTypeName.substring(0, index) + 'TrDisp';
    	}
    	else
    		dispatcherTypeName = originalTypeName + 'TrDisp';

	
		Type obType = Type.forName(dispatcherTypeName);
		IF9TriggerDispatcher dispatcher = (obType == null) ? null : (IF9TriggerDispatcher)obType.newInstance();
    	return dispatcher;
    }
}