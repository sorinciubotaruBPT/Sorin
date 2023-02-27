/**
 * @description       : 
 * @author            : Sorin Ciubotaru BearingPoint GmbH
 * @group             : 
 * @last modified on  : 02-23-2023
 * @last modified by  : Sorin Ciubotaru, BearingPoint GmbH
**/
trigger AccountTrigger on Account (before update, after insert) {
    AccountTriggerHandler.checkContractValidity(Trigger.new);
    switch on Trigger.operationType {
        when BEFORE_UPDATE {
            AccountTriggerHandler.checkContractValidity(Trigger.new);
        }

        when AFTER_INSERT {
            AccountTriggerHandler.generateCards(Trigger.new);
        }
    }
}