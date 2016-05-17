class Test < ActiveRecord::Base
	belongs_to :task

	validates :task, presence: true
	validates :path_in, :path_out, presence: true

	after_create do
		task_path = self.task.path
		in_path = task_path + "/input/" + self.id.to_s + ".txt"
		out_path = task_path + "/output/" + self.id.to_s + ".txt"
		spawn("touch", in_path)
		spawn("touch", out_path)
		spawn("cp #{self.path_in} #{in_path}")
		spawn("cp #{self.path_out} #{out_path}")
		self.update(path_in: in_path, path_out: out_path)
	end	

end
