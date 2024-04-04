/**
* @description This class has helper methods.
*/

public with sharing class UtilityClass {
	 
	/**
	* @description Gets the type name of the SObject.
	* @param SObject The SObject for which the name to be obtained.
	* @return String - The type name.
	*/
	public static String getSObjectTypeName(SObject so) {
		return so.getSObjectType().getDescribe().getName();
	}
	public static boolean isValidEmailAddress(string testEmail){
		Boolean res = true;
		if(testEmail == null){
			return !res;
		}
		
		string localAddr;
		if(testEmail.contains('@')){ 
		  localAddr = testEmail.substring(0,testEmail.indexOf('@')-1);	
		}else{
			return !res;
		}
		
		if(testEmail.length() > 250 
		   || localAddr.length() > 63){
			res = false;
		}
		String emailRegex = '([a-zA-Z0-9_\\-\\.]+)@((\\[a-z]{1,3}\\.[a-z]{1,3}\\.[a-z]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})'; 
		//'^[a-zA-Z0-9._|\\\\%#~`=?&/$^*!}{+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}$'; // source: <a href="http://www.regular-expressions.info/email.html" target="_blank">http://www.regular-expressions.info/email.html</a>
		Pattern MyPattern = Pattern.compile(emailRegex);
		Matcher MyMatcher = MyPattern.matcher(testEmail);
	
		if(!MyMatcher.matches()) 
		    res = false;
		return res;	
	}
}