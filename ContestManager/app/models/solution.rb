class Solution < ActiveRecord::Base
	include ApplicationHelper
	
	belongs_to :task
	belongs_to :compile_method

	validates :compile_method, presence: true
	validates :path, presence: true
	validates :task, presence: true

	after_create do 
		method = self.compile_method
		newPath = HOME + "/solutions/#{method.name}/#{self.id}"
		spawn("touch", "#{newPath}.#{method.ext}")
		`cp #{self.path} #{newPath}.#{method.ext}`
		`rm #{self.path}`
		self.update(path: newPath, verdict: "Received")
		running
	end

	before_destroy do 
		spawn("rm", self.path + "." + self.compile_method.ext) if File.exist?(self.path + "." + self.compile_method.ext)
		spawn("rm", self.path + "-log.txt") if File.exist?(self.path + "-log.txt")
	end

	def compiling 
		self.update!(verdict: "compiling...")
		method = self.compile_method
		`cp #{self.path}.#{method.ext} solutions/#{method.name}/solve.#{method.ext}`
		return if !method.compilation
		path_build = "#{self.path}-log.txt"
		pid = spawn(method.compilation, err: path_build)
		Process.waitpid(pid)
		verd = check(path_build)
		
		self.update(verdict: "CE") if verd == false
	end

	def running 
		self.update!(verdict: "Wait")
		Scheduler.invoke(self)
	end

private 
	def check(path) 
		return !File.open(path, "r").read.include?("error") if File.exist?(path)
		true
	end

end
