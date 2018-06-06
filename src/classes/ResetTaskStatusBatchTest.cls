@isTest
private class ResetTaskStatusBatchTest {

	@isTest static void resetTaskStatusTest() {
		Contact cont = new Contact(LastName = 'TestContact2', Points__c = 10);
		upsert cont;

		cont = [SELECT Id, Points__c FROM Contact WHERE LastName = 'TestContact2'];

		HTask__c task = new HTask__c(Name = 'TestTask2', Type__c = 'Daily', Contact__c = cont.Id, Status__c = 'Completed');
		upsert task;

		test.startTest();
	  Database.executeBatch(new ResetTaskStatusBatch());
		test.stopTest();

		task = [SELECT Id, Status__c FROM HTask__c WHERE Name = 'TestTask2'];

		System.assertEquals('New', task.Status__c);
	}
}