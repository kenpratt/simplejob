$:.unshift(File.expand_path("../../../lib", __FILE__))

require "simplejob"

SimpleJob::Worker.start do
  handle "a_task" do |props|
    puts "got x: #{props[:x]}"
    sleep 1
  end
end
