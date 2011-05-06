$:.unshift(File.expand_path("../../../lib", __FILE__))

require "simplejob"

SimpleJob.send("coffee")
SimpleJob.send("pie", :flavor => "apple", :size => "12in")
SimpleJob.send("ice_cream", :flavor => "vanilla")
SimpleJob.send("milkshake", :flavor => "chocolate")
SimpleJob.send("mousse")
SimpleJob.send("mousse")
SimpleJob.send("mousse")
