@isTest
global class EndOfDayScheduleTest {

	@isTest static void dailyTest() {
		Contact contBefore = new Contact(LastName = 'TestContact1', Points__c = 10, Email = 'amancebo@altimetrik.com');
		upsert contBefore;

		contBefore = [SELECT Id, Points__c, Email FROM Contact WHERE LastName = 'TestContact1'];

		HTask__c task = new HTask__c(Name = 'TestTask1', Difficulty__c = 'Hard', Type__c = 'Daily', Contact__c = contBefore.Id, DueDate__c = Date.parse('01/06/2018'));
		upsert task;

		Contact cont2 = new Contact(LastName = 'TestContact2', Points__c = 10);
		upsert cont2;

		cont2 = [SELECT Id, Points__c FROM Contact WHERE LastName = 'TestContact2'];

		HTask__c task2 = new HTask__c(Name = 'TestTask2', Type__c = 'Daily', Contact__c = cont2.Id, Status__c = 'Completed');
		upsert task2;

		String chron = '0 0 0 * * ?';
		test.startTest();
		System.schedule('Test EndOfDay', chron, new EndOfDaySchedule());
		test.stopTest();

		Contact contAfter = [SELECT Id, Points__c FROM Contact WHERE LastName = 'TestContact1'];
		task2 = [SELECT Id, Status__c FROM HTask__c WHERE Name = 'TestTask2'];
		System.assertEquals(contBefore.Points__c - 2.5,contAfter.Points__c);
		System.assertEquals('New', task2.Status__c);
	}
}