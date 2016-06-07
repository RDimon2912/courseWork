class TasksController < ApplicationController

	def index 
		@tasks = Task.all
		@solutions = Solution.all
	end

	def new 
		@task = Task.new
	end


	def show
		@task = Task.find(params[:id])
		@solves = Solution.where('task_id = ? AND verdict = "OK"', @task.id).order('time_run').limit(10)
	end
	
	def edit 

	end

	def create
		name = params[:task][:name]
		description = params[:task][:description]
		time_limit = params[:task][:time_limit]
		@task = Task.create(name: name, description: description, time_limit: time_limit)
		if @task.id 
			redirect_to task_path(@task)
		else 
			render :new
		end
	end
end