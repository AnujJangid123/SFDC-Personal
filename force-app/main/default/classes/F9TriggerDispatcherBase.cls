public virtual class F9TriggerDispatcherBase implements IF9TriggerDispatcher { 
	private static IF9TriggerHandler beforeInserthandler;
	private static IF9TriggerHandler beforeUpdatehandler;
	private static IF9TriggerHandler beforeDeleteHandler;
	private static IF9TriggerHandler afterInserthandler;
	private static IF9TriggerHandler afterUpdatehandler;
	private static IF9TriggerHandler afterDeleteHandler;
	private static IF9TriggerHandler afterUndeleteHandler;

    public virtual void bulkBefore() {}
    public virtual void bulkAfter() {}
    public virtual void beforeInsert(F9TriggerParameters tp) {} 
    public virtual void beforeUpdate(F9TriggerParameters tp) {}
    public virtual void beforeDelete(F9TriggerParameters tp) {}
    public virtual void afterInsert(F9TriggerParameters tp) {} 
    public virtual void afterUpdate(F9TriggerParameters tp) {}
    public virtual void afterDelete(F9TriggerParameters tp) {}
    public virtual void afterUnDelete(F9TriggerParameters tp) {}
    public virtual void andFinally() {}
    /** 
	* @description Called by the event handlers. If this is the first call in the context, then this method will create a new 
	*				instance of the appropriate handler and execute the mainEntry method. If there is an existing call runing 
	*				on the same context, then this method will use the existing handler instance created by the original call
	*				and execute the inProgressEntry method.
	* @param ITriggerHandler The trigger handler instance. The dispatcher need to pass an instance of the trigger handler, such
	*							as AccountAfterInsertTriggerHandler if this is the first call in a given context. If it is retry,
	*							then the dispatcher will need to pass null.
	* @param F9TriggerParameters The trigger parameters passed by the framework.
	* @param F9TriggerParameters.TriggerEvent The trigger event.
	*/
   	protected void execute(IF9TriggerHandler handlerInstance, F9TriggerParameters tp, F9TriggerParameters.TriggerEvent tEvent) {
    	if(handlerInstance != null) {
    		if(tEvent == F9TriggerParameters.TriggerEvent.beforeInsert)
    			beforeInsertHandler = handlerInstance;
    		if(tEvent == F9TriggerParameters.TriggerEvent.beforeUpdate)
    			beforeUpdateHandler = handlerInstance;
    		if(tEvent == F9TriggerParameters.TriggerEvent.beforeDelete)
    			beforeDeleteHandler = handlerInstance;
    		if(tEvent == F9TriggerParameters.TriggerEvent.afterInsert)
    			afterInsertHandler = handlerInstance;
    		if(tEvent == F9TriggerParameters.TriggerEvent.afterUpdate)
    			afterUpdateHandler = handlerInstance;
    		if(tEvent == F9TriggerParameters.TriggerEvent.afterDelete)
    			afterDeleteHandler = handlerInstance;
    		if(tEvent == F9TriggerParameters.TriggerEvent.afterUnDelete)
    			afterUndeleteHandler = handlerInstance;
    		handlerInstance.mainEntry(tp);
    		//handlerInstance.updateObjects();
    	}
    	else {
    		if(tEvent == F9TriggerParameters.TriggerEvent.beforeInsert)
    			beforeInsertHandler.inProgressEntry(tp);
    		if(tEvent == F9TriggerParameters.TriggerEvent.beforeUpdate)
    			beforeUpdateHandler.inProgressEntry(tp);
    		if(tEvent == F9TriggerParameters.TriggerEvent.beforeDelete)
    			beforeDeleteHandler.inProgressEntry(tp);
    		if(tEvent == F9TriggerParameters.TriggerEvent.afterInsert)
    			afterInsertHandler.inProgressEntry(tp);
    		if(tEvent == F9TriggerParameters.TriggerEvent.afterUpdate)
    			afterUpdateHandler.inProgressEntry(tp);
    		if(tEvent == F9TriggerParameters.TriggerEvent.afterDelete)
    			afterDeleteHandler.inProgressEntry(tp);
    		if(tEvent == F9TriggerParameters.TriggerEvent.afterUnDelete)
    			afterUndeleteHandler.inProgressEntry(tp);
    	}
    }
}