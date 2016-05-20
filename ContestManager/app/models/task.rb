class Task < ActiveRecord::Base
	include ApplicationHelper

	has_many :solutions
	has_many :tests
	
	validates :name, presence: true

	after_create do 
		name = "#{self.id}-#{self.name.capitalize}"
		self.update(name: name)
		self.update(time_limit: 2) if !self.time_limit
		name.tr!(' ', '_')
		path = HOME + "/tasks/#{name}"
		spawn("mkdir", path)
		spawn("mkdir", path + "/input")
		spawn("mkdir", path + "/output")
		spawn("touch", path + "/path_tests.txt")
		self.update(path: path)
	end

	before_destroy do
		Solution.where("task_id = ?", self.id).each { |s| s.destroy }
		spawn("rm", "-r", self.path)
	end

	def add_test(path_in, path_out) 
		Test.create(path_in: path_in, path_out: path_out, task: self)
	end

	def retesting
		solves = Solution.where("task_id = ?", self.id)
		solves.each { |s| s.running }
	end

	def true_solves
		sum = 0
		Solution.where("task_id = ?", self.id).each { |x| sum += 1 if x.verdict == "OK" }
		sum
	end

end