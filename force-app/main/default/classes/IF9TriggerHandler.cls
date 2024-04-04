public interface IF9TriggerHandler {

	void mainEntry(F9TriggerParameters tp); 
	void inProgressEntry(F9TriggerParameters tp);
	void updateObjects();
}