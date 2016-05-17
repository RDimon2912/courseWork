# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#task = Task.create(name: "Иван и самолёты")
#Task.all[0].add_test("~/test/in/1.txt", "~/test/out/1.txt")
#comp = CompileMethod.create(name: "gnu_c++", compilation: "g++ -std=c++11 -o solve solve.cpp", run: "solve", ext: "cpp")
#c2   = CompileMethod.create(name: "ruby", run: "ruby solve.rb", ext: "rb")
#sol  = Solution.create(path: "~/test/LehaTashit.cpp", compile_method: CompileMethod.all[0], task: Task.last)
#sol2 = Solution.create(path: "~/gitTest/test.rb", compile_method: CompileMethod.last, task: Task.last)
Task.all.each { |t| t.retesting }
sleep(10)