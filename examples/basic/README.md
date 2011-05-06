Basic producer/consumer
=======================

Open a couple of terminal windows with consumers, and then run the producer:

    ruby -rubygems consumer.rb
    ruby -rubygems consumer.rb
    ruby -rubygems producer.rb

You should see the consumers pulling requests of the queue and processing them. Try killing and restarting one or both of them, or even restarting RabbitMQ. No jobs should be lost.
