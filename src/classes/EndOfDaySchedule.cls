global class EndOfDaySchedule implements Schedulable {
    
    global void execute(SchedulableContext SC) {
       
    	resolveDailyTaskPoints();
        
        resetTaskStatus();
    }
    
    private static void resolveDailyTaskPoints(){
        
        List<HTask__c> ltask = [SELECT Id 
                                FROM HTask__c 
                                WHERE Status__c <> 'Completed' 
                                AND Type__c = 'Daily' 
                                AND DueDate__c < :Date.today()];
        
        Map<string, Contact> lcont = new Map<string, Contact>();
        
        for(HTask__c task:ltask){            
            
            if(lcont.containsKey(task.Id)){
                Contact conta = [SELECT Id, Name, Points__c FROM Contact WHERE Id = :task.Contact__c];
                conta.Points__c -= task.Points__c;
                lcont.put(conta.Id, conta);
            }
            else{
                Contact conta = lcont.get(task.Id);
                conta.Points__c  -= task.Points__c;
            }
        }
        
        update lcont.values();
    }
    
    private static void resetTaskStatus(){
        
        List<HTask__c> ltask = [SELECT Id 
                                FROM HTask__c 
                                WHERE Status__c <> 'New' 
                                AND Type__c <> 'TO-DO'];
        
        for(HTask__c task : ltask){
            task.Status__c = 'New';
        }
        
        update ltask;
    }
}