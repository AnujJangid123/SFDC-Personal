public with sharing class recordDebugLimits {
    
    public static void recordDebugSOQLLimits(string sMethod){
    
    	System.Debug(LOGGINGLEVEL.INFO, sMethod + ' : ' + Limits.getQueries());
    }
}