({
	completeTask : function(component){
		var action = component.get("c.changeStatus");
		var task = component.get("v.taskItem");
		action.setParams({
			task: task,
			status: "Completed",
		});

		action.setCallback(this, function(response){
			if(response.getState() == 'SUCCESS'){
				var taskComponent = component.find("taskDetailId");
				$A.util.addClass(taskComponent, "slds-hide");
			}
		})

		$A.enqueueAction(action);
	},
	habitDoneEx : function(component, event){
		var action = component.get("c.habitDone");

		var buttonParam = event.currentTarget;
		var habitPositive = (buttonParam.dataset.value == 'positive');

		var task = component.get("v.taskItem");
		action.setParams({
			task: task,
			positive: habitPositive,
		});

		var habitPoints = component.get("v.habitPoints");
		component.set("v.habitPoints", habitPositive ? habitPoints + task.Points__c : habitPoints - task.Points__c);
		$A.enqueueAction(action);
	},
	deleteTaskEx : function(component){
		var action = component.get("c.deleteTask");
		var task = component.get("v.taskItem");
		action.setParams({
			task:task
		});

		action.setCallback(this, function(response){
			if(response.getState() == 'SUCCESS'){
				var taskComponent = component.find("taskDetailId");
				$A.util.addClass(taskComponent, "slds-hide");
			}
		})

		$A.enqueueAction(action);
	}
})