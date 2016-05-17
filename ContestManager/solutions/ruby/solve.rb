=begin
require_relative 'mod'

class Scheduler
	def initialize
		@@arr = []
		@@invoker = Thread.new {}
		@@block = proc do
			while !@@arr.empty?
				puts "HERE"
				sleep(0.1)
				puts @@arr[0]
				@@arr.delete_at(0)
			end
		end
	end
	def self.add(local)
		@@arr.push(local)
		p @@invoker.alive?
		@@invoker = Thread.new(&@@block) unless @@invoker.alive?
	end
	def self.prin
		print "There are " 
		p @@arr
	end
end
Scheduler.new

Scheduler.add(1)
Scheduler.prin
sleep(2)
Scheduler.prin
Scheduler.add("124356")
Scheduler.add(3)
Scheduler.add(5)
Scheduler.prin

sleep(3)

home = Dir.pwd
s = "g++ -o solve solve.cpp s"
s = " " + s + " "
s = s.split("solve").join(home + "/solve")
p s
=end
#p File.open("main.cpp").tap { |f| f.each { |l| puts l } }.size
a = gets
gets.chomp.split(" ").sort_by {|a| a.to_i}.each { |x| print "#{x} "}