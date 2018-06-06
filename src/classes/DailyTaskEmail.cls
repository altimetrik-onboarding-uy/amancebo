global class DailyTaskEmail implements Schedulable {

	global void execute(SchedulableContext  context)
	{
		//Messaging.sendEmail(EmailTest());
			Messaging.sendEmail(generateEmails());
	}

	final List<MessagePacket> messages;
	public DailyTaskEmail()
	{
			messages = new List<MessagePacket>{new MessagePacket()};
	}
	public List<Messaging.SingleEmailMessage> generateEmails()
	{
			List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
			for (MessagePacket message : messages) emails.add(message.generateEmail());
			return emails;
	}
	public DailyTaskEmail add(String toAddress, Id templateId, Id targetObjectId)
	{
			messages.add(new MessagePacket(toAddress, templateId, targetObjectId));
			return this;
	}

	public class MessagePacket
	{
			public final Id templateId;
			public final Id targetObjectId;
			public final String toAddress;
			public Messaging.SingleEmailMessage generateEmail()
			{
					Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
					Messaging.reserveSingleEmailCapacity(2);
				  String[] toAddresses = new String[]{ 'amancebo@altimetrik.com' };
				  email.setToAddresses(toAddresses);
				  email.setSenderDisplayName('Altibitica Support');
				  email.setSubject('You dont complete some daily task yesterday');
				  email.setReplyTo('amancebo@altimetrik.com');
				  email.setBccSender(false);
				  email.setUseSignature(false);
				  email.setPlainTextBody('Smigol');
					return email;
			}
			public MessagePacket(){

			}
			public MessagePacket(String toAddress, Id templateId, Id targetObjectId){
				this.toAddress = toAddress;
				this.templateId = templateId;
				this.targetObjectId = targetObjectId;
			}
	}
}