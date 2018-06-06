global class ResetTaskStatusBatch implements Database.Batchable<sObject> {

	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator([SELECT Id
																		FROM HTask__c
																		WHERE Status__c <> 'New'
																		AND Type__c <> 'TO-DO']);
	}

 	global void execute(Database.BatchableContext BC, List<HTask__c> scope) {
		for(HTask__c task : scope){
				task.Status__c = 'New';
		}

		update scope;
	}

	global void finish(Database.BatchableContext BC) {

	}

}