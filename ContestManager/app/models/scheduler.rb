class Scheduler < ActiveRecord::Base
	include ApplicationHelper

	@@queue = []
	@@invoker = Thread.new {}
	@@block = proc do
		while !@@queue.empty?
			solve = @@queue[0]
			@@queue.delete_at(0)
			solve.compiling
			next if solve.verdict == "CE"
			tests = Test.where("task_id = ?", solve.task_id)
			method = solve.compile_method
			time_run = nil
			ok = true
			tests.each do |t|
				next if !ok
				solve.update!(verdict: "Run on test #{t.id}")
		
				verd = self.checker(solve, t)	
				
				if verd[:v] == "OK"
					time_run ||= verd[:t]
					time_run = time_run > verd[:t] ? time_run : verd[:t]
					next
				end
				ok = false
				solve.update!(verdict: "TL #{t.id}", time_run: verd[:t]) if verd[:v] == "TL"
				solve.update!(verdict: "RE #{t.id}", time_run: verd[:t]) if verd[:v] == "RE"
				solve.update!(verdict: "WA #{t.id}", time_run: verd[:t]) if verd[:v] == "WA"
				
			end
			solve.update!(verdict: "OK", time_run: time_run) if ok
		end
	end
	

	def self.invoke(solve)
		@@queue.push(solve)
		@@invoker = Thread.new(&@@block) unless @@invoker.alive? 
	end

	def self.checker(solve, test) 
		path_out = HOME + "/solutions/" + solve.compile_method.name + "/output.txt"
		path_err = HOME + "/solutions/" + solve.compile_method.name + "/errors.txt"
		limit = solve.task.time_limit
		pid = nil
		tr = nil
		tl = Time.now
		begin
			Timeout::timeout( limit ) do
				pid ||= Process.spawn(solve.compile_method.run, in: test.path_in, out: path_out, err: path_err)	
				Process.waitpid(pid)
			end
		rescue Timeout::Error
			tr ||= Time.now
			`kill -9 #{pid}`
		end		
		tr ||= Time.now	
		timer = ((tr - tl) * 1000).to_i
		ret = {t: timer, v: nil}
		ret[:v] ||= "TL" if timer > limit*1000
		ret[:v] ||= "RE" if File.open(path_err).size != 0
		ch = `#{HOME}/check "#{test.path_out}" #{path_out}`
		if ch == "true"
			ret[:v] ||= "OK" 
		else
			ret[:v] ||= "WA"
		end
		return ret
	end

end