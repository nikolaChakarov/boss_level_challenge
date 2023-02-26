public with sharing class CTPeopleTracingController {
    public static List<People_Tracing__c> getTraces(String recordId) {
        List<People_Tracing__c> people = [
            SELECT Id, Name, Contact_Date__c, Contact_Type__c, Person_1__c, Person_2__c 
            FROM People_Tracing__c 
            WHERE Id = :recordId
            ORDER BY Contact_Date__c DESC];

        return people;
    }

    public static List<People_Tracing__c> checkDuplicates(List<People_Tracing__c> peopleTraces) {
        
        List<People_Tracing__c> existingPeople = [
            SELECT Id, Name, Contact_Date__c, Contact_Type__c, Person_1__c, Person_2__c 
            FROM People_Tracing__c];
            
        List<People_Tracing__c> duplicates = new List<People_Tracing__c>();
            
        for(People_Tracing__c person: existingPeople) {
            if (!peopleTraces.contains(person)) {
                duplicates.add(person);
            }
        }

        return duplicates;
    }
}