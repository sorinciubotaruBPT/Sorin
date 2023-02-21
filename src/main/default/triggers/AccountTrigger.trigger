/**
 * @description       : 
 * @author            : Sorin Ciubotaru BearingPoint GmbH
 * @group             : 
 * @last modified on  : 02-21-2023
 * @last modified by  : Sorin Ciubotaru, BearingPoint GmbH
**/
trigger AccountTrigger on Account (before update) {
    AccountTriggerHandler.checkContractValidity(Trigger.new);
}