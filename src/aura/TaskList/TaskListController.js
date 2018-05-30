({
	doInit : function(component, event, helper) {
		var action = component.get("c.getTODOTasks");
		action.setCallback(this, function(response){
				if(response.getState() == "SUCCESS"){
						component.set("v.taskTODOItems", response.getReturnValue());
				}
		});

		$A.enqueueAction(action);

		var action = component.get("c.getDailyTasks");
		action.setCallback(this, function(response){
				if(response.getState() == "SUCCESS"){
						component.set("v.taskDailyItems", response.getReturnValue());
				}
		});

		$A.enqueueAction(action);

		var action = component.get("c.getHabitTasks");
		action.setCallback(this, function(response){
				if(response.getState() == "SUCCESS"){
						component.set("v.taskHabitItems", response.getReturnValue());
				}
		});

		$A.enqueueAction(action);
	}
})
