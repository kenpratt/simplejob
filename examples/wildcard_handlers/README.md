Wildcard handlers
=================

Open the consumer and wiretap in terminal windows, and then run the producer:

    ruby -rubygems consumer.rb
    ruby -rubygems wiretap.rb
    ruby -rubygems producer.rb

You should see the consumer pulling requests of the queue and processing them, and the wiretap printing everything out. Try killing and restarting them, or even restarting RabbitMQ. No jobs or wiretapped jobs should be lost.
