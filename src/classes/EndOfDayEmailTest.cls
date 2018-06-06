@isTest
global class EndOfDayEmailTest {

	@isTest static void sendEmailsTest() {
		Contact cont = new Contact(LastName = 'TestContact1', Points__c = 10, Email = 'amancebo@altimetrik.com');
		upsert cont;

		cont = [SELECT Id, Points__c, Email FROM Contact WHERE LastName = 'TestContact1'];

		HTask__c task = new HTask__c(Name = 'TestTask1', Difficulty__c = 'Hard', Type__c = 'Daily', Contact__c = cont.Id, DueDate__c = Date.parse('01/06/2018'));
		upsert task;

		test.startTest();
		Database.executeBatch(new ResolveDailyTaskPointsBatch());
		test.stopTest();
	}
}