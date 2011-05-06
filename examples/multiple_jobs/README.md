Multiple jobs mapped to different consumers
===========================================

Open a few terminal windows with various combinations of consumers, and then run the producer:

    ruby -rubygems drink_consumer.rb
    ruby -rubygems food_consumer.rb
    ruby -rubygems food_consumer.rb
    ruby -rubygems producer.rb

You should see the consumers pulling requests of the queue and processing them. Try killing and restarting them, or even restarting RabbitMQ. No jobs should be lost.
