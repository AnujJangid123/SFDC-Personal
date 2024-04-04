trigger O4AdminDeleteCheck on Task (before delete) {
    	Id pid=Userinfo.getProfileId();  
  		profile profilname=[select Name from Profile where id=:pid];
    	for(Task accDup:Trigger.old){
        if(profilname.Name!='System Administrator'){
        accDup.addError('You are not allowed to Delete.Only Admin can.' );                                    
      }                       
    }    
}