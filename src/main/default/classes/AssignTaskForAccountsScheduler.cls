/**
 * @description       : 
 * @author            : Sorin Ciubotaru BearingPoint GmbH
 * @group             : 
 * @last modified on  : 02-23-2023
 * @last modified by  : Sorin Ciubotaru, BearingPoint GmbH
**/

/**
 AssignTaskForAccountsScheduler schedulerJob = new AssignTaskForAccountsScheduler();
 String sch = '0 0 4 * * ?';
 String jobId = System.schedule('Assign a task for each account that didnt have a task assigned in last 60 days', sch, schedulerJob);
**/

public with sharing class AssignTaskForAccountsScheduler implements Schedulable {
    public void execute(SchedulableContext sc) {
        Database.executeBatch(new AssignTaskForAccountsBatch());
    }
}