/**
 * @description       : 
 * @author            : Sorin Ciubotaru BearingPoint GmbH
 * @group             : 
 * @last modified on  : 02-23-2023
 * @last modified by  : Sorin Ciubotaru, BearingPoint GmbH
**/
public with sharing class DetermineExpiredAdoptionBatch implements Database.Batchable<sObject>{
    public Database.QueryLocator start(Database.BatchableContext bc) {
        Date nextTenDays = Date.today().addDays(10);
        return Database.getQueryLocator([SELECT Id, End_Date__c, Status__c, Account__r.Email__c FROM Adoption__c 
        WHERE (End_Date__c <= TODAY OR End_Date__c = :nextTenDays) AND Status__c != 'Expired']);
    }

    public void execute(Database.BatchableContext BC, List<Adoption__c> adoptions){
        List<Adoption__c> expiredAdoptions = new List<Adoption__c>();
        List<String> emailsForSoonToExpireAdoptions = new List<String>();
        for (Adoption__c adoption : adoptions) {
            if (adoption.End_Date__c <= Date.today()) {
                adoption.Status__c = 'Expired';
                expiredAdoptions.add(adoption);
            } else {
                emailsForSoonToExpireAdoptions.add(adoption.Account__r.Email__c);
            }
        }

        update expiredAdoptions;

        //TODO: write the logic for the email to be sent later on
    }

    public void finish(Database.BatchableContext BC){

    }
}