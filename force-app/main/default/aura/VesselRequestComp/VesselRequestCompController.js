({
    
    doInit: function(component, event, helper) {
      //  helper.loadVendors(component);
        var stages = [
            { label: 'In-Processing', value: 'In-Processing' },
            { label: 'Processed', value: 'Processed' }
        ];
        component.set("v.forwardRequestStages", stages);
        // Fetch records from server or initialize empty records
        var initialRecordList = [
            {Id:'', Name: '',Price: null,ETA:null,ETD:null, isEditing: false }
        ];
        console.log('@@--->initialRecordList14'+component.get("v.vendorQuoteRecordList"));
        component.set("v.vendorQuoteRecordList", initialRecordList);
    },
    handleSelect: function(component, event, helper) {
        
    },
    toggleShowAvailableVendors: function(component, event, helper) {
        component.set("v.showAvailableVendors", !component.get("v.showAvailableVendors"));
         
        
        
        var label = event.getSource().get("v.label");
            if(label == 'Open Search') {
                event.getSource().set("v.label","Close Search")
            } else {
                event.getSource().set("v.label","Open Search")
            }
        
    },
    handleIdsFromChild: function(component, event, helper) {
        var idsData = event.getParam("idsData");
        console.log("IDs received from child component:", idsData);
        var lstSelectedVendorRecords = component.get("v.lstSelectedVendorIds");
        var lstSelectedVendorIds;
        var resultMap = new Map();
        
        for (var i = 0; i < idsData.length; i++) {
            var parts = idsData[i].split('@@@');
            if (parts.length === 2) {
                resultMap.set(parts[0], parts[1]);
            }
        }
        var mapArray = Array.from(resultMap.entries());
        component.set("v.forwardedRequestRecordMap", mapArray);
        console.log('resultMap@@---->'+JSON.stringify(mapArray));
        lstSelectedVendorIds = Array.from(resultMap.keys());
        console.log("forwardedRequestRecordMap@@@----->", JSON.stringify(component.get("v.forwardedRequestRecordMap")));
        // Identify unique IDs that are not in lstSelectedVendorIds
        var newUniqueIds = lstSelectedVendorIds.filter(id => !lstSelectedVendorRecords.includes(id));
        // Merge new unique IDs into lstSelectedVendorIds
        lstSelectedVendorIds = lstSelectedVendorIds.concat(newUniqueIds);
        var uniqueArray = [...new Set(lstSelectedVendorIds)];
        console.log('@@@@uniqueArray------>'+uniqueArray); 
        // Update the component attribute
        component.set("v.lstSelectedVendorIds", uniqueArray);
        console.log("lstSelectedVendorIds@@@----->", uniqueArray);
        helper.createForwarderRequests(component, event, helper);
    },
    toggleCollapse: function(component, event, helper) {
		component.set("v.isCollapsed", !component.get("v.isCollapsed"));
    },
    toggleEditMode: function(component, event, helper) {
        var index = event.getSource().get("v.value");
        var recordList = component.get("v.vendorQuoteRecordList");
        recordList[index].isEditing = !recordList[index].isEditing;
        component.set("v.vendorQuoteRecordList", recordList);
        
        if(!recordList[index].isEditing){
            var hiddenInput = component.find("hiddenInput");
            var hiddenValue = hiddenInput.get("v.value");
            console.log('recordList[index]@@@@---->'+JSON.stringify(recordList[index])+'@@_------hiddenValue-->'+hiddenValue);
            var parts = hiddenValue.split('@@@@');
            console.log('parts[0]@@---->'+parts[0]+'parts[1]@@---->'+parts[1])
            var quoteList = component.get("v.vesselQuoteList");
            quoteList.push({Name: recordList[index].Name,Price__c: recordList[index].Price,ETA__c:recordList[index].ETA,ETD__c:recordList[index].ETD, Shipper__c: parts[0], Forwarder_Request__c: parts[1]}); // Replace with actual field API names
            component.set("v.vesselQuoteList", quoteList);
            
            helper.createVesselQuoteRecord(component, event, helper);
        }
    },

    deleteRow: function(component, event, helper) {
        var index = event.getSource().get("v.value");
        var recordList = component.get("v.vendorQuoteRecordList");
        recordList.splice(index, 1);
        component.set("v.vendorQuoteRecordList", recordList);
    },

    addNewRow: function(component, event, helper) {
        var recordList = component.get("v.vendorQuoteRecordList");
        recordList.push( { Id:'',Name: '',Price: null,ETA:null,ETD:null, isEditing: false });
        component.set("v.vendorQuoteRecordList", recordList);
        console.log('@@--->initialRecordList74'+component.get("v.vendorQuoteRecordList"));
    }
})