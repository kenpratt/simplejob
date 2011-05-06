simplejob
=========

Painless job queueing, backed by AMQP.

The design goals were:

* Super simple interface
* Robust jobs that never get lost
* Jobs don't get marked complete until they are finished (they survive reboots)
* One job queue per worker pool, with jobs mapped to that queue (for easy monitoring)
* Jobs which throw exceptions are logged and removed, preventing infinite job loops

Installation
------------

<pre>
$ gem install simplejob
</pre>

Hello World
-----------

Start your [RabbitMQ](http://www.rabbitmq.com/) server (install one if necessary).

<pre>
$ edit producer.rb
</pre>

<pre>
require "simplejob"

SimpleJob.send("hello")
</pre>

<pre>
$ edit consumer.rb
</pre>

<pre>
require "simplejob"

SimpleJob::Worker.start do
  handle "hello" do |props|
    puts "got it!"
  end
end
</pre>

<pre>
$ ruby -rubygems consumer.rb
</pre>

<pre>
$ ruby -rubygems producer.rb
</pre>

More examples
-------------

See the [examples directory](http://github.com/kenpratt/simple-job-queue/tree/master/examples).
