global class EndOfDaySchedule implements Schedulable {

    global void execute(SchedulableContext SC) {

      Database.executeBatch(new ResolveDailyTaskPointsBatch());

      Database.executeBatch(new EndOfDayEmail());

      Database.executeBatch(new ResetTaskStatusBatch());
    }
}