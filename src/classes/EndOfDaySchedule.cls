global class EndOfDaySchedule implements Schedulable {
    
    global void execute(SchedulableContext SC) {
        
        List<HTask__c> ltask = [SELECT Id 
                                FROM HTask__c 
                                WHERE Status__c <> 'Completed' 
                                AND Type__c = 'Daily' 
                                AND DueDate__c < :Date.today()];
        
        for(HTask__c task:ltask){            
            Contact conta = [SELECT Id, Name FROM Contact WHERE Id = :task.Contact__c];
            conta.Points__c -= task.Points__c;
            
            update conta;
        }
    }
}