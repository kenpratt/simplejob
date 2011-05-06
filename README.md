simplejob
=========

Painless job queueing, backed by AMQP.

* Super simple interface
* Robust jobs that never get lost
* Jobs don't get marked complete until they are finished (they survive reboots/kill -9)
* One work queue per worker pool, with one or more job names mapped to each work queue (for easy monitoring)
* Jobs which throw exceptions are logged and removed, preventing infinite job-retry loops

Installation
------------

<pre>
$ gem install simplejob
</pre>

Example
-------

Start your [RabbitMQ](http://www.rabbitmq.com/) server (install one if necessary).

### Producer

<pre>
require "simplejob"

SimpleJob.send("hello")
</pre>

### Consumer

<pre>
require "simplejob"

SimpleJob::Worker.start do
  handle "hello" do |props|
    puts "got it!"
  end
end
</pre>

<pre>
$ ruby -rubygems producer.rb
$ ruby -rubygems consumer.rb
</pre>

More examples
-------------

See the [examples directory](http://github.com/kenpratt/simplejob/tree/master/examples).
