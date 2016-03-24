require 'time'
require 'timeout'

class Task
	
	def initialize(name, way) 
		@way = "./main.cpp"
		@tests = []
		@name = "sort"
		@in = "./intput.txt"
		@timer = 3
		@kol = 0
		
		@way = way.to_s
		@name = name.to_s
	end
	def addTest(way) 
		@tests << way.to_s
		@kol += 1
	end
	def start	
		l = Time.now
		begin
			Timeout::timeout( @timer.to_i ) do 
				`#{@name}`
			end
		rescue
		Timeout::Error
			puts "Time Limit"
		end
		r = Time.now
		return ((r - l) * 1000).to_i
	end
	def test(num)
		`cp #{tests[ num.to_i ]} #{@in}`
		time = start

	end
	def compiling
		`g++ -Wall -o #{@name} #{@way}`
		if $? != 0
			puts "Build faled!"
			abort
		end
		puts "Build ok!"
	end
	def addFileIn(way)
		@in = way.to_s
	end
	def addFileOut(way) 
		@out = way.to_s
	end
	def addTimeError(timer)
		@timer = timer.to_i
	end

end

taskA = Task.new("sort", "./main.cpp")
taskA.compiling
taskA.addTimeError(2)
taskA.addFileIn("./input.txt")
taskA.addFileOut("./output.txt")
taskA.addTest(".in/in1.in")