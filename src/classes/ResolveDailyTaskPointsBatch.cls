global class ResolveDailyTaskPointsBatch implements Database.Batchable<SObject> {

	global Database.QueryLocator start(Database.BatchableContext BC) {

		Date d = Date.today();
			return Database.getQueryLocator([SELECT Id, Contact__c, Points__c
																				FROM HTask__c
																				WHERE Status__c <> 'Completed'
																				AND Type__c = 'Daily'
																				AND DueDate__c < :d]);
	}

 	global void execute(Database.BatchableContext BC, List<HTask__c> scope) {
		Map<string, Contact> lcont = new Map<string, Contact>();

		for(HTask__c task:scope){

				if(!lcont.containsKey(task.Id)){
						Contact conta = [SELECT Id, Name, Points__c FROM Contact WHERE Id = :task.Contact__c];
						conta.Points__c -= task.Points__c;
						lcont.put(conta.Id, conta);
				}
				else{
						Contact conta = lcont.get(task.Id);
						conta.Points__c  -= task.Points__c;
				}
		}

		update lcont.values();
	}

	global void finish(Database.BatchableContext BC) {

	}

}