// userListComponentController.js
({
    init: function(component, event, helper) {
        // Retrieve the list of users and profiles from the server
        var action = component.get("c.getUsersWithProfiles");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.users", response.getReturnValue().users);
                component.set("v.profiles", response.getReturnValue().profiles);
            } else {
                console.error("Failed to retrieve user profiles");
            }
        });
        $A.enqueueAction(action);
    },
    
    updateProfile: function(component, event, helper) {
        var selectedProfile = event.getSource().get("v.value");
        component.set("v.selectedProfile", selectedProfile);
    },
    
    saveChanges: function(component, event, helper) {
        var users = component.get("v.users");
        var selectedProfile = component.get("v.selectedProfile");
        
        // Prepare the data for bulk update
        var profilesToUpdate = [];
        for (var i = 0; i < users.length; i++) {
            var user = users[i];
            if (user.ProfileId !== selectedProfile) {
                profilesToUpdate.push({
                    userId: user.Id,
                    profileId: selectedProfile
                });
            }
        }
        
        // Call the server-side method to perform bulk profile updates
        var action = component.get("c.updateUserProfiles");
        action.setParams({
            profilesToUpdate: profilesToUpdate
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("Profiles updated successfully");
            } else {
                console.error("Failed to update profiles");
            }
        });
        $A.enqueueAction(action);
    }
})