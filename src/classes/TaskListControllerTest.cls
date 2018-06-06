@isTest
global class TaskListControllerTest {
	@testSetup static void setup(){

		Contact cont1 = new Contact(LastName = 'TestContact2');
		upsert cont1;

		HTask__c task1 = new HTask__c(Name = 'Test1', Type__c = 'Daily', Status__c = 'New', Contact__c = cont1.Id);
		HTask__c task2 = new HTask__c(Name = 'Test2', Type__c = 'Daily', Status__c = 'Completed', Contact__c = cont1.Id);

		List<HTask__c> ltask = new List<HTask__c>();
		ltask.add(task1);
		ltask.add(task2);

		upsert ltask;
	}

	@isTest static void getAllTaskTest() {
		test.startTest();

		Contact cont1 = [SELECT Id FROM Contact WHERE LastName = 'TestContact2'];

		List<HTask__c> ltask = TaskListController.getAllTasks();

		Boolean contains1 = false;
		Boolean contains2 = false;
		for(HTask__c task : ltask){
			if(task.Name == 'Test1'){
				contains1 = true;
			}

			if(task.Name == 'Test2'){
				contains2 = true;
			}

			if(contains1 && contains2){
				break;
			}
		}

		test.stopTest();

		System.assertEquals(true, contains1 && contains2);
	}

	@isTest static void getAllUncompletedTaskTest(){
		test.startTest();

		Contact cont1 = [SELECT Id FROM Contact WHERE LastName = 'TestContact2'];

		List<HTask__c> ltask = TaskListController.getAllUncompletedTask();

		Boolean contains1 = false;
		Boolean contains2 = false;
		for(HTask__c task : ltask){
			if(task.Name == 'Test1'){
				contains1 = true;
			}

			if(task.Name == 'Test2'){
				contains2 = true;
			}
		}

		test.stopTest();

		System.assertEquals(true, contains1 && !contains2);
	}
}
