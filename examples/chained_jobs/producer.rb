$:.unshift(File.expand_path("../../../lib", __FILE__))

require "simplejob"

SimpleJob.send("step1", :x => 12)
