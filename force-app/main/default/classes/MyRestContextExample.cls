@RestResource(urlMapping='/MyRestContextExample/*')
global with sharing class MyRestContextExample {
    
    @HTTPPost
    global static void insertAccount(String name, String rating){   
        RestRequest accountRequest = RestContext.request;
        String accountRequestURL = accountRequest.requestURI;
        String accountId = accountRequestURL.substring(accountRequestURL.lastIndexOf('/')+1);
        Account acc = new Account();
        acc.Name = name;
        acc.Rating = rating;
        insert acc;
    }
}