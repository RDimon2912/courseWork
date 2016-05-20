class ContestController < ApplicationController
	def index
		@tasks = Task.all
	end
end
