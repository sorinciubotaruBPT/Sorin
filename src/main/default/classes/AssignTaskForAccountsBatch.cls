/**
 * @description       : Assign a task for each account that didnt have a task assigned in last 60 days
 * @author            : Sorin Ciubotaru BearingPoint GmbH
 * @group             : 
 * @last modified on  : 02-27-2023
 * @last modified by  : Sorin Ciubotaru, BearingPoint GmbH
**/

public with sharing class AssignTaskForAccountsBatch implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id FROM Account]);
    }

    public void execute(Database.BatchableContext bc, List<Account> accounts) {
        Date daysAgo = Date.today().addDays(-60);
        List<Task> tasksToInsert = new List<Task>();
        List<Task> oldTasks = [SELECT AccountId, ActivityDate FROM Task];
        Map<Id, List<Task>> tasksByAccountId = new Map<Id, List<Task>>();
        for(Task task : oldTasks) {
            if(!tasksByAccount.containsKey(task.AccountId)){
                tasksByAccount.put(task.AccountId, new List<Task>());
            } else {
                tasksByAccount.get(task.AccountId).add(task);
            }
        }

        for (Account account : accounts) {
            if(tasksByAccount.containsKey(account.Id)) {
                if(tasksByAccount.get(account.Id)[0].ActivityDate <= daysAgo) {
                    Task newTask = new Task(Subject = 'Get in contact with customer', WhatId = account.Id, Status = 'Not Started', Priority = 'Normal', ActivityDate = Date.today());
                    tasksToInsert.add(newTask);
                }
            }
        }

        insert tasksToInsert;
    }

    public void finish(Database.BatchableContext bc){

    }
}