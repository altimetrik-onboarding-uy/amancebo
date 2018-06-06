@isTest
private class DailyTaskEmailTest {

	@isTest static void testEmail() {
		String chron = '0 0 0 * * ?';
		test.startTest();
		System.schedule('Test Daily Email', chron, new DailyTaskEmail());
		test.stopTest();
	}
}