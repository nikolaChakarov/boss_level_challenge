public with sharing class CTLocationController {
    public static List<Location__c> getRecentStatusChanges() {
        return [SELECT Id, OwnerId, Name, LastModifiedDate, Address__c, Pincode__c, Red_Score__c, Status_Update_Date__c, Status__c FROM Location__c ORDER BY Status_Update_Date__c DESC NULLS LAST LIMIT 100];
    }

    public static List<Location__c> searchLocation(String searchTerm) {
        searchTerm = searchTerm + '%';

        return [SELECT Id, OwnerId, Name, LastModifiedDate, Address__c, Pincode__c, Red_Score__c, Status_Update_Date__c, Status__c 
                FROM Location__c 
                WHERE Name 
                LIKE :searchTerm
                    OR Pincode__c LIKE :searchTerm
                    OR Address__c LIKE :searchTerm
                ORDER BY Status_Update_Date__c DESC];  
    }

    public static Location__c getLocationById(String id) {
        return [SELECT Id, OwnerId, Name, LastModifiedDate, Address__c, Pincode__c, Red_Score__c, Status_Update_Date__c, Status__c FROM Location__c WHERE Id = :id];
    }
}