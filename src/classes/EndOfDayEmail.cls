global class EndOfDayEmail implements Database.Batchable<sObject> {

	String query;

	global EndOfDayEmail() {

	}

	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator('SELECT Id, Name, Contact__c'
																		+ 'FROM HTask__c'
																		+ 'WHERE Status__c <> \'Completed\''
																		+ 'AND Type__c = \'Daily\'');
	}

 	global void execute(Database.BatchableContext BC, List<HTask__c> scope) {

		Map<string, List<HTask__c>> mtask = new Map<string, List<HTask__c>>();

		for(HTask__c task : scope){
			if(!mtask.containsKey(task.Contact__c)){
				mtask.put(task.Contact__c, new List<HTask__c>());
			}

			mtask.get(task.Contact__c).add(task);
		}

		List<Messaging.SingleEmailMessage> lemail = new List<Messaging.SingleEmailMessage>();
		for(string contactId : mtask.keySet()){
			Contact cont = [SELECT Id, Email FROM Contact WHERE Id = :contactId];
			string message = 'Today you have this task that does not been completed: \n';
			for(HTask__c task : mtask.get(contactId)){
				message += task.Name + '\n';
			}
			message += '\nHave a good day!';

			lemail.add(sendEmailToContact(cont.Email, message));
		}

		Messaging.sendEmail(lemail);
	}

	private static Messaging.SingleEmailMessage sendEmailToContact(string email, string message){
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
		return mail;
	}

	global void finish(Database.BatchableContext BC) {

	}
}
