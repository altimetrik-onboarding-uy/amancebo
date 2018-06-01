({
	doInit : function(component) {
		var action = component.get("c.getAllUncompletedTask");
		action.setCallback(this, function(response){
			if(response.getState() == "SUCCESS"){
                component.set("v.taskTODOItems", response.getReturnValue().filter(x => x.Type__c == 'TO-DO'));
                component.set("v.taskDailyItems", response.getReturnValue().filter(x => x.Type__c == 'Daily'));
                component.set("v.taskHabitItems", response.getReturnValue().filter(x => x.Type__c == 'Habit'));
            }
		});

		$A.enqueueAction(action);
	}
})