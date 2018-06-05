public with sharing class TaskDetailController {
	@AuraEnabled
	public static boolean changeStatus(HTask__c task, string status) {

		try{
			task.Status__c = status;

			update task;

			return true;
		}
		catch(Exception e){
			return false;
		}
	}

    @AuraEnabled
    public static void HabitDone(HTask__c task, boolean positive){

        Contact cont = [SELECT Id, Name, Points__c FROM Contact WHERE Id = :task.Contact__c];

        cont.Points__c = positive ? cont.Points__c + task.Points__c : cont.Points__c - task.Points__c;

        update cont;
    }
}
