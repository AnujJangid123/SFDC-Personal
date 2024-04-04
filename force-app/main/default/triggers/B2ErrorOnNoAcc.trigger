trigger B2ErrorOnNoAcc on Contact (before insert) {
    for(Contact con:trigger.new){
        if(con.AccountId == null){
            con.AddError('No Associated Account Found!!!');
            
        }
    }
}