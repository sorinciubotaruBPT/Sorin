/**
 * @description       : 
 * @author            : Sorin Ciubotaru BearingPoint GmbH
 * @group             : 
 * @last modified on  : 02-21-2023
 * @last modified by  : Sorin Ciubotaru, BearingPoint GmbH
**/
public with sharing class AccountTriggerHandler {
    public static void checkContractValidity(List<Account> accList) {
        Set<Id> accountIds = new Set<Id>();
        for (Account a : accList) {
            accountIds.add(a.Id);
        }
        List<Contract> contractsList = [SELECT AccountId, Name, ContractNumber, EndDate FROM Contract WHERE AccountId IN :accList];
        Map<Id, List<Contract>> contractsByAccount = new Map<Id, List<Contract>>();
        for(Contract con : contractsList) {
            if(!contractsByAccount.containsKey(con.AccountId)){
                contractsByAccount.put(con.AccountId, new List<Contract>());
            }

            contractsByAccount.get(con.AccountId).add(con);
        }

        for (Account acc : accList) {
            List<Contract> contracts = contractsByAccount.get(acc.Id);
            acc.ContractInformation__c = '';
            for (Contract c : contracts) {
                if((system.today()).daysBetween(Date.valueOf(c.EndDate)) < 0) {
                    acc.ContractInformation__c += c.ContractNumber + ',';
                }
            }
        }
    }
}