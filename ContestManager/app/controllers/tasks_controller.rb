class TasksController < ApplicationController

	def index 
		@tasks = Task.all
		@solutions = Solution.all
	end

	def show
		@task = Task.find(params[:id])
		@solves = Solution.where('task_id = ? AND verdict = "OK"', @task.id).order('time_run').limit(10)
	end

end