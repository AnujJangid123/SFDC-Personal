({
	init : function(component, event, helper) {
        var modalBody;
        var modalFooter;
        $A.createComponents([
            ["c:fetchAccoutnRecord",{}]
        ],
         function(components, status){
             if (status === "SUCCESS") {
                 modalBody = components[0];
                 component.find('overlayLib').showCustomModal({
                     header: "Paginaniton In Lightning",
                     body: modalBody,
                     footer: modalFooter,
                     showCloseButton: true,
                     cssClass: "my-modal,my-custom-class,my-other-class",
                     closeCallback: function() {
                     }
                 });
             }
         });
    }
})