trigger AccountTriggers on Account (before insert, after insert,before update, after update,before delete, after delete,after undelete) {
    if(Trigger.isInsert || Trigger.isUpdate){
        if(trigger.isBefore){
        //AccountHandler.DupRecord(trigger.new);
        //AccountHandler.BillToShip(trigger.new);
        //AccountHandler.KarthicWithBanking(trigger.new);
        //AccountHandler.IndustryAsBanking(trigger.new);
        }
        if(trigger.isAfter){
        //AccountHandler.IndustryAsEnergy(trigger.new);
        //AccountHandler.ClientContact(trigger.new);
        //AccountHandler.MailToAdmin(trigger.new);
        AccountHandler.AddUserToAccountTeamMember(trigger.new);
        }
    }
}