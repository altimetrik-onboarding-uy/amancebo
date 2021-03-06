trigger completeHTaskTrigger on HTask__c (after update) {

    HTask__c task = Trigger.New[0];

    Contact conta = [SELECT Id, Name, Points__c FROM Contact WHERE Id = :task.Contact__c];

    if(task.Type__c == 'TO-DO'){
        if(task.Status__c == 'Completed' && Trigger.Old[0].Status__c <> 'Completed'){
            if(task.DueDate__c <> null || task.DueDate__c <= Datetime.now()){
                conta.Points__c += task.Points__c;
            }
            else{
                conta.Points__c -= (task.Points__c/2);
            }

            update conta;
        }
    }
    else if(task.Type__c == 'Daily'){
        if(task.Status__c == 'Completed' && Trigger.Old[0].Status__c <> 'Completed'){
            conta.Points__c += task.Points__c;

            update conta;
        }
    }
}
