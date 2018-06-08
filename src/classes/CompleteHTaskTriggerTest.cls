@isTest
global class CompleteHTaskTriggerTest {

	@isTest static void completeDailyTask() {
		test.startTest();
		Contact contBefore = new Contact(LastName = 'TestContact1', Points__c = 10);
		insert contBefore;

		HTask__c task = new HTask__c(Name = 'TestTask1', Type__c = 'Daily', Contact__c = contBefore.Id, Status__c = 'New', Difficulty__c = 'Hard');
		insert task;

		task.Status__c = 'Completed';
		update task;

		Contact contAfter = [SELECT Id, Points__c FROM Contact WHERE LastName = 'TestContact1'];
		task = [SELECT Id, Points__c FROM HTask__c WHERE Name = 'TestTask1'];
		test.stopTest();

		System.assertEquals(contBefore.Points__c + task.Points__c, contAfter.Points__c);
	}

	@isTest static void completeTODOTask() {
		test.startTest();
		Contact contBefore = new Contact(LastName = 'TestContact2', Points__c = 10);
		insert contBefore;

		HTask__c task = new HTask__c(Name = 'TestTask2', RecordTypeId = '012f4000000FSbYAAW', Type__c = 'TO-DO', Status__c = 'New', Contact__c = contBefore.Id, Difficulty__c = 'Hard', DueDate__c = Date.parse('6/6/2018'));
		insert task;

		task.Status__c = 'Completed';
		update task;

		Contact contAfter = [SELECT Id, Points__c FROM Contact WHERE LastName = 'TestContact2'];
		task = [SELECT Id, Points__c FROM HTask__c WHERE Name = 'TestTask2'];
		test.stopTest();

		System.assertEquals(contBefore.Points__c + task.Points__c, contAfter.Points__c);
	}

}
