@isTest
global class CompleteHTaskTriggerTest {

	@isTest static void completeDailyTask() {
		test.startTest();
		Contact cont1 = new Contact(LastName = 'TestContact1', Points__c = 10);
		upsert cont1;

		Contact cont1Before = [SELECT Id, Name, Points__c FROM Contact WHERE LastName = 'TestContact1'];

		HTask__c task = new HTask__c(Name = 'TestTask1', Type__c = 'Daily', Contact__c = cont1Before.Id, Status__c = 'New', Difficulty__c = 'Hard');
		upsert task;

		task = [SELECT Id, Status__c, Points__c FROM HTask__c WHERE Name = 'TestTask1'];
		task.Status__c = 'Completed';
		upsert task;

		Contact cont1After = [SELECT Id, Points__c FROM Contact WHERE LastName = 'TestContact1'];
		test.stopTest();
		System.assertEquals(cont1Before.Points__c + task.Points__c, cont1After.Points__c);
	}

	@isTest static void completeTODOTask() {
		test.startTest();
		Contact cont2 = new Contact(LastName = 'TestContact2', Points__c = 10);
		upsert cont2;

		Contact cont2Before = [SELECT Id, Name, Points__c FROM Contact WHERE LastName = 'TestContact2'];

		HTask__c task = new HTask__c(Name = 'TestTask2', RecordTypeId = '012f4000000FSbYAAW', Type__c = 'TO-DO', Status__c = 'New', Contact__c = cont2Before.Id, Difficulty__c = 'Hard', DueDate__c = Date.parse('6/6/2018'));
		upsert task;

		task = [SELECT Id, Status__c, Points__c FROM HTask__c WHERE Name = 'TestTask2'];
		task.Status__c = 'Completed';
		upsert task;

		Contact cont2After = [SELECT Id, Points__c FROM Contact WHERE LastName = 'TestContact2'];
		test.stopTest();
		System.assertEquals(cont2Before.Points__c + task.Points__c, cont2After.Points__c);
	}

}