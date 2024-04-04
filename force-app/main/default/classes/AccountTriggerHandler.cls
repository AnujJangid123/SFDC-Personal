public class AccountTriggerHandler {
    public static void IndustryAccount(list<Account> listacc){
        for(account acc:listacc){

		acc.ShippingStreet=acc.BillingStreet;
		acc.ShippingCity=acc.BillingCity;
		acc.ShippingState=acc.BillingState;
		acc.ShippingPostalCode=acc.BillingPostalCode;
		acc.ShippingCountry=acc.BillingCountry;
    	}
    }
}