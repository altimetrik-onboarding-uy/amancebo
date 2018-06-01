public with sharing class TaskDetailController {
	@AuraEnabled
	public static boolean changeStatus(HTask__c task, string status) {
        
		if (status == 'Completed'){
			task.Status__c = 'Completed';
		}
		else if (status == 'In Process'){
			task.Status__c = 'In Process';
		}
		else if (status == 'New'){
			task.Status__c = 'New';
		}

		update task;
        
        return true;
	}
    
    @AuraEnabled
    public static void HabitDone(HTask__c task, boolean positive){
        System.debug(task.Contact__c);
        Contact cont = [SELECT Id, Name, Points__c FROM Contact WHERE Id = :task.Contact__c];
        System.debug(cont.Id);
                
        cont.Points__c = positive ? cont.Points__c + task.Points__c : cont.Points__c - task.Points__c;
        
        update cont;
    }
}