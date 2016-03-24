require 'time'
require 'timeout'

class Task
	@way
	@tests = []
	@name
	@in
	@time
	def initialize(name, way) 
		@way = way.to_s
		@name = name.to_s
	end
	def addTest(way) 
		@tests[ @kol ] = way.to_s
		@kol += 1
	end
	def test(num)

	end
	def compiling
		puts `g++ -Wall -o #{@name} #{@way}`
		$?
	end
	def addFileIn(way)
		@in = way.to_s
	end
	def addFileOut(way) 
		@out = way.to_s
	end
	def addTimeError

	end
end

taskA = Task.new("sort", "./main.cpp")
errors = taskA.compiling
puts errors
if errors != 0 
	puts "Build faled!"
	abort
end
puts "Build ok!"
