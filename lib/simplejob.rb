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
      raise "Message properties should be a Hash" unless props.kind_of?(Hash)
      log.info "[simplejob] New job: #{topic}, #{props.inspect}"
      publish(topic, props.to_json)
      stop
    end
  end

end

def log
  Logger.new(STDOUT)
end
