class SolutionController < ApplicationController

	def index 

	end

	def create

	end

	def show

	end

	def update

	end

	def submit
		uploaded_io = params[:file]
		method = CompileMethod.find(params[:comp_id])
		task = Task.find(params[:id])
		path_to = Rails.root.join(uploaded_io.original_filename)
		File.open(path_to, 'wb') do |file|
    		file.write(uploaded_io.read)
  		end
  		Solution.create(path: path_to, compile_method: method, task: task)
		redirect_to tasks_path
	end

	def edit
		@task = Solution.find(params[:id])
	end
end
