public interface IF9TriggerDispatcher {

	void bulkBefore();
	void bulkAfter();
	void andFinally();
	void beforeInsert(F9TriggerParameters tp);
	void beforeUpdate(F9TriggerParameters tp);
	void beforeDelete(F9TriggerParameters tp);
	void afterInsert(F9TriggerParameters tp);
	void afterUpdate(F9TriggerParameters tp);
	void afterDelete(F9TriggerParameters tp);
	void afterUnDelete(F9TriggerParameters tp);
}