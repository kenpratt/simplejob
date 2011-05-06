$:.unshift(File.expand_path("../../../lib", __FILE__))

require "simplejob"

SimpleJob::Worker.start(:queue_name => "foo") do

  handle "foo.*" do |props|
    puts "normal foo: #{props[:topic]}"
  end

  handle "foo.#" do |props|
    puts "catchall foo: #{props[:topic]}"
  end
end
