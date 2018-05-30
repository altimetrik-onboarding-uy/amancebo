public with sharing class TaskListController {
	@AuraEnabled
	public static List<Object> getAllTasks() {
		List<Object> ltask = [SELECT Id, Name, Description__c, Type__c FROM HTask__c];
		return ltask;
	}

	@AuraEnabled
	public static List<Object> getTODOTasks() {
		List<Object> ltask = [SELECT Id, Name, Description__c, Type__c
													FROM HTask__c
													WHERE Type__c = 'TO-DO'
													AND Status__c <> 'Completed'];
		return ltask;
	}

	@AuraEnabled
	public static List<Object> getDailyTasks() {
		List<Object> ltask = [SELECT Id, Name, Description__c, Type__c
													FROM HTask__c
													WHERE Type__c = 'Daily'
													AND Status__c <> 'Completed'];
		return ltask;
	}

	@AuraEnabled
	public static List<Object> getHabitTasks() {
		List<Object> ltask = [SELECT Id, Name, Description__c, Type__c
													FROM HTask__c
													WHERE Type__c = 'Habit'];
		return ltask;
	}
}
