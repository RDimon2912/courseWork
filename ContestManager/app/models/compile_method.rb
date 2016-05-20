class CompileMethod < ActiveRecord::Base
	include ApplicationHelper
	has_many :solutions

	validates :ext, presence: true
	validates :run, presence: true

	after_create do 
		@path = HOME + "/solutions/#{self.name}"
		spawn("mkdir", @path) if Dir.exist?(@path) == false
		if self.compilation
			s = " " + self.compilation.to_s + " " 
			s = s.split("solve").join(@path + "/solve")
			self.update(compilation: s)
		end
		s = " " + self.run.to_s + " " 
		s = s.split("solve").join(@path + "/solve")
		self.update(run: s)
	end

	before_destroy do 
		@path = HOME + "/solutions/#{self.name}"
		Solution.where("compile_method_id = ?", self.id).each { |s| s.destroy }
		spawn("rm", "-r", @path) if Dir.exist?(@path)
	end

end
