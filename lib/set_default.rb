#a list of installed rubies
#A tone more to do in here
@rubies = Dir.entries('rubies/').select {|entry| File.directory? File.join('rubies/',entry) and !(entry =='.' || entry == '..') }

i = 0
puts 'This is a list of your currently instlled ruby'
puts
@rubies.each do |r|
puts "#{i+=1}:" + " #{r}"
end
puts
puts "Enter the name of the ruby you want to use"
choice = gets.chomp.to_i

def set_default(arg)
	puts "#{@rubies[arg]}" + " is now default"
	
	system("lib/default.bat #{@rubies[arg]}")
end
puts

set_default(choice -1)