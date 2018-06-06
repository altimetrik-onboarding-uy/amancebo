@isTest
private class ResolveDailyTaskPointsBatchTest {

	@isTest static void resolveDailyTaskTest() {
		Contact cont = new Contact(LastName = 'TestContact1', Points__c = 10, Email = 'amancebo@altimetrik.com');
		upsert cont;

		cont = [SELECT Id, Points__c FROM Contact WHERE LastName = 'TestContact1'];

		HTask__c task = new HTask__c(Name = 'TestTask1', Difficulty__c = 'Hard', Type__c = 'Daily', Contact__c = cont.Id, DueDate__c = Date.parse('01/06/2018'));
		upsert task;

		test.startTest();
		Database.executeBatch(new ResolveDailyTaskPointsBatch());
		test.stopTest();

		Contact contBefore = [SELECT Id, Points__c FROM Contact WHERE LastName = 'TestContact1'];
		task = [SELECT Id, Points__c FROM HTask__c WHERE Name = 'TestTask1'];

		System.assertEquals(cont.Points__c - task.Points__c, contBefore.Points__c);
	}
}