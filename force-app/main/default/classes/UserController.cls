// UserController.cls
public class UserController {
    @AuraEnabled
    public static Map<String, Object> getUsersWithProfiles() {
        Map<String, Object> result = new Map<String, Object>();
        
        List<User> users = [SELECT Id, Name, Profile.Name, ProfileId FROM User];
        List<Profile> profiles = [SELECT Id, Name FROM Profile];
        
        result.put('users', users);
        result.put('profiles', profiles);
        
        return result;
    }
    
    @AuraEnabled
    public static void updateUserProfiles(List<Map<String, String>> profilesToUpdate) {
        List<User> usersToUpdate = new List<User>();
        for (Map<String, String> profileData : profilesToUpdate) {
            User user = new User(Id = profileData.get('userId'), ProfileId = profileData.get('profileId'));
            usersToUpdate.add(user);
        }
        
        update usersToUpdate;
    }
}