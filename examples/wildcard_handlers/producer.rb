$:.unshift(File.expand_path("../../../lib", __FILE__))

require "simplejob"

SimpleJob.send("foo.bar")
SimpleJob.send("foo.baz")
SimpleJob.send("foo.bar.baz")
SimpleJob.send("foo.bar.baz.bang")
SimpleJob.send("zap")
SimpleJob.send("zap.whizz")
