require 'time'
require 'timeout'

class Task
	
	def initialize(name, way) 
		@way = "./main.cpp"
		@tests = []
		@in = "./input.txt"
		@out = "./output.txt"
		@timer = 3
		@kol = 0
		@way = way.to_s
		@name = name.to_s
		@get = ""
	end
	def addTest(way) 
		@tests << way.to_s
		@kol += 1
	end
	def start	
		l = Time.now
		begin
			Timeout::timeout(@timer.to_i ) do 
				@get = runner
			end
		rescue
		Timeout::Error
			puts "Time Limit"
		end
		r = Time.now
		((r - l) * 1000).to_i
	end
	def test(num)
		`cp #{@tests[ num.to_i ]} #{@in}`
		start
	end
	def compiling
		`g++ -Wall -fexceptions -O2 -std=c++11 -c #{@way} -o #{@name}.o 2> build_log_#{@name}.txt`
		`g++ -o #{@name} #{@name}.o -s`
		f = File.open("build_log_#{@name}.txt")
		f.each do |str|
			puts str
		end
	end
	def de_compiling
		`rm #{@name}`
		`rm #{@in}`
		`rm #{@out}`
		`rm #{@name}.o`
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
	def runner
		`./#{@name} < #{@in} > #{@out}`
	end
end

class Checker < Task
	def de_compiling
		`rm #{@name}`
		`rm #{@in}`
		`rm #{@name}.o`
	end	
	def runner
		`./#{@name}`
	end
end

taskA = Task.new("sort", "main.cpp")
taskA.compiling

taskA.addTimeError(2)
taskA.addFileIn("./input.txt")
taskA.addFileOut("./output.txt")
taskA.addTest("./in/in1.in")

puts "#{taskA.test(0)}ms"

checker = Checker.new("checker", "./checker.cpp")
checker.compiling

checker.addFileIn("./outCheck.txt")
checker.addFileOut("./output.txt")
checker.addTest("./out/out1.out")
p checker.test(0)


taskA.de_compiling
checker.de_compiling

class TestingTask
	def initialize(task, checker) 
		@task = task
		@checker = checker
	end
end