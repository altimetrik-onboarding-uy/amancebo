global class EndOfDaySchedule implements Schedulable {

    global void execute(SchedulableContext SC) {

    	resolveDailyTaskPoints();

      sendEmails();

      resetTaskStatus();
    }

    private static void resolveDailyTaskPoints(){

        List<HTask__c> ltask = [SELECT Id, Contact__c, Points__c
                                FROM HTask__c
                                WHERE Status__c <> 'Completed'
                                AND Type__c = 'Daily'
                                AND DueDate__c < :Date.today()];

        Map<string, Contact> lcont = new Map<string, Contact>();

        for(HTask__c task:ltask){

            if(!lcont.containsKey(task.Id)){
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

    private static void sendEmails(){
      List<HTask__c> ltask = [SELECT Id, Name, Contact__c
                              FROM HTask__c
                              WHERE Status__c <> 'Completed'
                              AND Type__c = 'Daily'];

      Map<string, List<HTask__c>> mtask = new Map<string, List<HTask__c>>();

      for(HTask__c task : ltask){
        if(!mtask.containsKey(task.Contact__c)){
          mtask.put(task.Contact__c, new List<HTask__c>());
        }

        mtask.get(task.Contact__c).add(task);
      }

      for(string contactId : mtask.keySet()){
        Contact cont = [SELECT Id, Email FROM Contact WHERE Id = :contactId];
        string message = 'Today you have this task that doesn\'t been completed: \n';
        for(HTask__c task : mtask.get(contactId)){
          message += task.Name + '\n';
        }
        message += '\nHave a good day!';
        sendEmailToContact(cont.Email, message);
      }
    }

    private static void sendEmailToContact(string email, string message){
      Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
      Messaging.reserveSingleEmailCapacity(2);
      String[] toAddresses = new String[]{ email };
      mail.setToAddresses(toAddresses);
      mail.setSenderDisplayName('Altibitica Support');
      mail.setSubject('You dont complete some daily task yesterday');
      mail.setReplyTo('amancebo@altimetrik.com');
      mail.setBccSender(false);
      mail.setUseSignature(false);

      mail.setPlainTextBody(message);
      Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
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