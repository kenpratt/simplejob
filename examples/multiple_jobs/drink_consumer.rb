$:.unshift(File.expand_path("../../../lib", __FILE__))

require "simplejob"

SimpleJob::Worker.start(:queue_name => "drinks") do

  handle "coffee" do |props|
    puts "caffeine, here i come"
    sleep 1
  end

  handle "milkshake" do |props|
    puts "a #{props[:flavor]} milkshake, excellent!"
    sleep 1
  end

end
