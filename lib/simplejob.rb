require "amqp"
require "json"
require "logger"
require "active_support/core_ext/hash"

require "simplejob/client"
require "simplejob/worker"

module SimpleJob

  # Send a work request
  def self.send(topic, props = {})
    Client.start do
      send(topic, props)
      stop
    end
  end

end
