public class TaskListController {
	@AuraEnabled
	public static List<HTask__c> getAllTasks() {
		List<HTask__c> ltask = [SELECT Id, Name, Description__c, Type__c, Points__c, Contact__c FROM HTask__c];
		return ltask;
	}

  @AuraEnabled
  public static List<HTask__c> getAllUncompletedTask(){
	List<HTask__c> ltask = [SELECT Id, Name, Description__c, Type__c, Points__c, Contact__c
												FROM HTask__c
												WHERE Status__c <> 'Completed'];
	return ltask;
  }
}