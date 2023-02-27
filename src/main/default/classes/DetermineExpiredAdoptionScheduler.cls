/**
 * @description       : 
 * @author            : Sorin Ciubotaru BearingPoint GmbH
 * @group             : 
 * @last modified on  : 02-23-2023
 * @last modified by  : Sorin Ciubotaru, BearingPoint GmbH
**/
public with sharing class DetermineExpiredAdoptionScheduler implements Schedulable {
    public void execute(SchedulableContext SC) {
        Database.executeBatch(new DetermineExpiredAdoptionBatch(), 50);
    }
}