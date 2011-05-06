$:.unshift(File.expand_path("../../../lib", __FILE__))

require "simplejob"

1.upto(20).each do |x|
  puts "sending x: #{x}"
  SimpleJob.send("a_task", :x => x)
end
