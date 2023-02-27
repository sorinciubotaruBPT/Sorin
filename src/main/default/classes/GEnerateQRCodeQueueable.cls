/**
 * @description       : 
 * @author            : Sorin Ciubotaru BearingPoint GmbH
 * @group             : 
 * @last modified on  : 02-23-2023
 * @last modified by  : Sorin Ciubotaru, BearingPoint GmbH
**/
public with sharing class GEnerateQRCodeQueueable implements Queueable, Database.AllowsCallouts {
    private Account acc;
    public GEnerateQRCodeQueueable(Account acc) {
        this.acc = acc;
    }

    public void execute(QueueableContext context) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=' + acc.Id);
        req.setMethod('GET');

        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug('TTTTT res get body' + res.getBody());
        // Account.QrCode__c res = res.getBody();
        System.enqueueJob(new GenerateCardsQueueable(res.getBody()));
    }
}