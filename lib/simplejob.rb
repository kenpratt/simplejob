require "amqp"
require "json"
require "logger"
require "active_support/core_ext/hash"

require "simplejob/client"
require "simplejob/worker"
require "simplejob/hash_extensions"

module SimpleJob

  # Send a work request
  def self.send(topic, props = {}, client_opts = {})
    Client.start(client_opts) do
      send(topic, props)
      stop
    end
  end

end
