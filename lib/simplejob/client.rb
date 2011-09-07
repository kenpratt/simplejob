module SimpleJob
  DEFAULT_EXCHANGE_NAME = "simplejob"

  class Client
    def self.start(opts = {}, &proc)
      instance = new
      instance.start(opts, &proc)
      instance
    end

    def start(opts, &proc)
      client = self
      AMQP.start(opts) do
        Signal.trap("INT") { puts; stop }
        Signal.trap("TERM") { puts; stop }

        @channel = AMQP::Channel.new
        @exchange = exchange(opts[:exchange_name] || DEFAULT_EXCHANGE_NAME)

        instance_exec(opts, &proc)
      end
    end

    def stop
      AMQP.stop { EM.stop }
    end

    def exchange(name)
      @channel.topic(name, :durable => true, :auto_delete => false)
    end

    def queue(name)
      @channel.queue(name, :durable => true, :auto_delete => false)
    end

    def bind(queue, key)
      queue.bind(@exchange, :key => key)
    end

    def publish(topic, message)
      @exchange.publish(message, :routing_key => topic, :persistent => true)
    end

    def subscribe(queue, &proc)
      queue.subscribe({ :ack => true }, &proc)
    end

    alias_method :orig_send, :send
    def send(topic, props = {})
      raise "Message properties should be a Hash" unless props.kind_of?(Hash)
      log.info "[simplejob] New job: #{topic}, #{props.truncated_inspect}"
      publish(topic, props.to_json)
    end

    private

    def log
      Client.log
    end

    def self.log
      @logger ||= setup_logger
    end

    def self.setup_logger
      if defined?(LOGGER)
        LOGGER
      elsif defined?(Rails.logger)
        Rails.logger
      else
        Logger.new(STDOUT)
      end
    end

  end
end
