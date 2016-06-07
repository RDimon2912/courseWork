class SolutionController < ApplicationController

	def status
		task = Task.find(params[:task_id])
		@page_num = params[:page_id] || 1
		@solves_all = Solution.where('task_id = ?', task.id)
		@solves = @solves_all.order(created_at: :desc).offset( (@page_num.to_i - 1) * 15 ).limit(15)
		@kol_pages = ((@solves_all.count + 14) / 15).to_i
		@par = params
	end

	def show 
		@solve = Solution.find(params[:solve_id])
		@ext = @solve.compile_method.ext
		@path = @solve.path + "." + @ext
		@path_log = @solve.path + "-log.txt"
	end

	def submit
		uploaded_io = params[:file]
		
		method = CompileMethod.find(params[:comp_id])
		task = Task.find(params[:task_id])
		if !uploaded_io
			redirect_to task_path(task.id)
			return
		end
		path_to = Rails.root.join(uploaded_io.original_filename)
		File.open(path_to, 'wb') do |file|
    		file.write(uploaded_io.read)
  		end
  		`rm path_to`
  		 Solution.create(path: path_to, compile_method: method, task: task)
		redirect_to controller: :solution, action: :status, task_id: task.id
  		
		
	end

	def edit
		@task = Solution.find(params[:id])
	end
end

