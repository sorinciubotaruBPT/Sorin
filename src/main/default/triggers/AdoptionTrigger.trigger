/**
 * @description       : 
 * @author            : Sorin Ciubotaru BearingPoint GmbH
 * @group             : 
 * @last modified on  : 02-20-2023
 * @last modified by  : Sorin Ciubotaru, BearingPoint GmbH
**/
trigger AdoptionTrigger on Adoption__c (before insert, before update) {
    // if(Trigger.isBefore && Trigger.isInsert) {

    // } else if (Trigger.isBefore && Trigger.isUpdate) {
        
    // }

    switch on Trigger.operationType {
        when BEFORE_INSERT {
            AdoptionTriggerHandler.checkAdoptionDuplicate(Trigger.new);
        }

        when BEFORE_UPDATE{
            AdoptionTriggerHandler.checkAdoptionDuplicate(Trigger.new);
        }
    }

    
}