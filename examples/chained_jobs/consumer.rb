$:.unshift(File.expand_path("../../../lib", __FILE__))

require "simplejob"

SimpleJob::Worker.start do
  handle "step1" do |props|
    x = props[:x]
    puts "step1: x = #{x}"

    sleep 0.5
    send "step2", { :x => x + x }
  end

  handle "step2" do |props|
    x = props[:x]
    puts "step2: x = #{x}"

    sleep 0.5
    send "step3", { :x => x * 3 }
  end

  handle "step3" do |props|
    x = props[:x]
    puts "step3: x = #{x}"

    sleep 0.5
    send "step4", { :x => x - 42 }
  end

  handle "step4" do |props|
    x = props[:x]
    puts "step4: x = #{x}"
    puts "FIN"
  end
end
