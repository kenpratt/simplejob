$:.unshift(File.expand_path("../../../lib", __FILE__))

require "simplejob"

SimpleJob::Worker.start(:queue_name => "food") do

  handle "pie" do |props|
    puts "mmm, a #{props[:size]} #{props[:flavor]} pie, my favorite!"
    sleep 3
  end

  handle "ice_cream" do |props|
    puts "gross, #{props[:flavor]} ice cream"
    sleep 1
  end

  handle "mousse" do |props|
    puts "what's a mousse?"
    sleep 0.1
  end

end
