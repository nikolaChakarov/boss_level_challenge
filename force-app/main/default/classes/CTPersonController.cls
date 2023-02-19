public with sharing class CTPersonController {

    public static String getToken(String mobile) {
        // generate unique hash using MD5 algorythm
        Blob phoneNumber = Blob.valueOf(mobile);
        Blob hash = Crypto.generateDigest('MD5', phoneNumber);

        // get the string value of hash blob;
        String result = EncodingUtil.base64Encode(hash);
        System.debug('hash: '+  result);

        return result;
    }

    public static List<Person__c> getRecentHealthChanges() {
        List<Person__c> people = [SELECT Id, Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c FROM Person__c ORDER BY Status_Update_Date__c DESC NULLS LAST LIMIT 100];

        return people;
    }

    public static List<Person__c> searchPeople(String searchTerm) {
        searchTerm = searchTerm + '%';
        List<Person__c> searchResult = 
        [SELECT Id, Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c 
            FROM Person__c 
            WHERE Name LIKE :searchTerm
                OR Mobile__c LIKE :searchTerm
                OR Token__c LIKE :searchTerm 
            ORDER BY Status_Update_Date__c DESC  NULLS LAST];
        return searchResult;
    }

    public static Person__c getPersonById(String id) {
        List<Person__c> people = [SELECT Id, Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c FROM Person__c WHERE Id = :id];

        if(people != null && people.size() > 0) {
            return people[0];
        } else {
            return null;
        }
    }
}