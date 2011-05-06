$:.unshift(File.expand_path("../../../lib", __FILE__))

require "simplejob"

SimpleJob::Worker.start(:queue_name => "wiretap") do

  handle "#" do |props|
    puts "wiretapped: #{props[:topic]}"
  end

end
