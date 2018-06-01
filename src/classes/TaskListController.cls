public with sharing class TaskListController {
	@AuraEnabled
	public static List<Object> getAllTasks() {
		List<Object> ltask = [SELECT Id, Name, Description__c, Type__c, Points__c, Contact__c FROM HTask__c];
		return ltask;
	}

    @AuraEnabled
    public static List<Object> getAllUncompletedTask(){
		List<Object> ltask = [SELECT Id, Name, Description__c, Type__c, Points__c, Contact__c
													FROM HTask__c
													WHERE Status__c <> 'Completed'];
		return ltask;
    }
}