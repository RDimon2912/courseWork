`g++ -o check checker.cpp`
ok = `./check`
ok = ok.to_s
if (ok == "true")
	puts "TRUE"
else
	puts "FALSE"
end
`rm check`