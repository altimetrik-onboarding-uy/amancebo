@isTest
global class TaskDetailControllerTest {
	@testSetup static void setup(){
		Contact cont1 = new Contact(LastName = 'TestContact1', Points__c = 10);
		upsert cont1;

		cont1 = [SELECT Id, Name FROM Contact WHERE LastName = 'TestContact1'];

		HTask__c task1 = new HTask__c(Name = 'Test1', Type__c = 'Daily', Status__c = 'New', Contact__c = cont1.Id);
		HTask__c task2 = new HTask__c(Name = 'Test2', Type__c = 'Habit', Difficulty__c = 'Hard', Status__c = 'New', Contact__c = cont1.Id, RecordTypeId = '012f4000000FUKDAA4');

		List<HTask__c> ltask = new List<HTask__c>();
		ltask.add(task1);
		ltask.add(task2);

		upsert ltask;
	}

	@isTest static void changeStatusTest() {
		HTask__c task = [SELECT Id, Name, Status__c FROM HTask__c WHERE Name = 'Test1'];

		test.startTest();
		Boolean finish = TaskDetailController.changeStatus(task, 'Completed');
		test.stopTest();

		task = [SELECT Id, Name, Status__c FROM HTask__c WHERE Name = 'Test1'];
		System.assertEquals('Completed', task.Status__c);
		System.assertEquals(true, finish);

	}

	@isTest static void habitDoneTest(){
		HTask__c task = [SELECT Id, Points__c, Contact__c FROM HTask__c WHERE Name = 'Test2'];
		Contact contBefore = [SELECT Id, Points__c FROM Contact WHERE LastName = 'TestContact1'];

		test.startTest();
		TaskDetailController.habitDone(task, true);
		test.stopTest();

		Contact contAfter = [SELECT Id, Points__c FROM Contact WHERE Lastname = 'TestContact1'];
		System.assertEquals(contAfter.Points__c, contBefore.Points__c + task.Points__c);
	}
}