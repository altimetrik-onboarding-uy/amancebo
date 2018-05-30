trigger completeHTaskTrigger on HTask__c (before update) {
    
    HTask__c task = [SELECT Id, Contact__c, Type__c, Status__c, DueDate__c, Points__c FROM HTask__c WHERE Id IN :Trigger.New];
    
    Contact conta = [SELECT Id, Name, Points__c FROM Contact WHERE Id = :task.Contact__c];

    if(task.Type__c == 'TO-DO'){
        if(Trigger.New[0].Status__c == 'Completed' && task.Status__c <> 'Completed'){
            if(task.DueDate__c <> null || task.DueDate__c <= Datetime.now()){
                conta.Points__c += task.Points__c;
            }
            else{
                conta.Points__c -= (task.Points__c/2);
            }            
        }
    }
    else if(task.Type__c == 'Daily'){
        if(Trigger.New[0].Status__c == 'Completed' && task.Status__c <> 'Completed'){
            if(task.DueDate__c <> null || task.DueDate__c <= Datetime.now()){
                conta.Points__c += task.Points__c;
            }      
        }
    }
    
    update conta;
}