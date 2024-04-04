public class OpportunityStageNames {
    public static void fetchAndPrintOpportunityNames() {
        Map<String, List<String>> stageOpportunityNamesMap = new Map<String, List<String>>();

        for (Opportunity opp : [SELECT Name, StageName FROM Opportunity]) {
            if (!stageOpportunityNamesMap.containsKey(opp.StageName)) {
                stageOpportunityNamesMap.put(opp.StageName, new List<String>());
            }
            stageOpportunityNamesMap.get(opp.StageName).add(opp.Name);
        }

        for (String stage : stageOpportunityNamesMap.keySet()) {
            System.debug('Stage: ' + stage);
            System.debug('Opportunities: ' + String.join(stageOpportunityNamesMap.get(stage), ','));
        }
    }
}