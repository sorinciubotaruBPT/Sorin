/**
 * @description       : 
 * @author            : Sorin Ciubotaru BearingPoint GmbH
 * @group             : 
 * @last modified on  : 02-21-2023
 * @last modified by  : Sorin Ciubotaru, BearingPoint GmbH
**/
public with sharing class AdoptionTriggerHandler {
    public static void checkAdoptionDuplicate(List<Adoption__c> newAdoptions) {
        Set<Id> relevantAccountIds = new Set<Id>();
        Set<Id> relevantAnimalIds = new Set<Id>();
        Set<Id> adoptionsFromTriggerIds = new Set<Id>();
        Map<Id, List<Adoption__c>> newAdoptionsByAccountId = new Map<Id,List<Adoption__c>>();
        for(Adoption__c adop : newAdoptions) {
            System.debug(adop.Account__c);
            System.debug(adop.Animal__c);
            adoptionsFromTriggerIds.add(adop.Id);

            if (!newAdoptionsByAccountId.containsKey(adop.Account__c)) {
                newAdoptionsByAccountId.put(adop.Account__c, new List<Adoption__c>());
            }

            newAdoptionsByAccountId.get(adop.Account__c).add(adop);
        }

        List<Adoption__c> existingAdoptions = [SELECT Account__c, Animal__c FROM Adoption__c 
        WHERE (Status__c = 'Active' 
        AND (Account__c IN :relevantAccountIds 
        OR Account__c IN :relevantAnimalIds) 
        AND ID NOT IN :adoptionsFromTriggerIds)];

        for(Adoption__C  existingAdoption : existingAdoptions)  {
            List<Adoption__c> newAdoptionsWithSameName = newAdoptionsByAccountId.get(existingAdoption.Account__c);
            if(newAdoptionsWithSameName != null) {
                for (Adoption__c newAdoptionSameName : newAdoptionsWithSameName)  {
                    if (newAdoptionSameName.Animal__c.equals(existingAdoption.Animal__c)){
                        newAdoptionSameName.addError('This record ia a duplicate!');
                    }
                    
                }
            }
        }
    }
}