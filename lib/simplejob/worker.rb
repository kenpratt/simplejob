module SimpleJob
  class Worker < Client
    def start(opts, &proc)
      super do
        # only fetch one message at a time instead of being greedy
        @channel.prefetch(1)

        # create the queue
        @queue = queue(opts[:queue_name] || "job_queue")

        # defer to instance to set up handlers
        instance_exec(&proc)

        # start processing jobs
        start_handler_loop
      end
    end

    def handle(key, &proc)
      # bind the message to the queue
      bind(@queue, key)

      # register the handler
      install_handler(key, proc)
    end

    private

    def start_handler_loop
      subscribe(@queue) do |headers, body|
        unless AMQP.closing?
          puts headers.inspect
          topic = headers.properties[:routing_key]

          begin
            start_time = Time.now
            log.info "\n#{"="*80}\n#{topic.upcase} BEGIN -- #{start_time}\n#{"="*80}"

            props = JSON.parse(body).with_indifferent_access
            props[:topic] = topic
            log.info "[worker] Props: #{props.inspect}"

            if handler = find_handler(topic)
              handler.call(props)
            else
              log.error "[worker] no handler installed for #{topic}"
            end

            end_time = Time.now
            elapsed = ((end_time - start_time) * 10).round / 10.0
            log.info "\n#{"="*80}\n#{topic.upcase} END -- #{end_time} (elapsed: #{elapsed}s)\n#{"="*80}\n"
          rescue Exception => error
            log.error "[worker] handle blew up for #{topic} with body:\n#{body}\n#{error}\n#{error.backtrace.join("\n")}"
          end

          headers.ack
        end
      end
    end

    def install_handler(key, proc)
      @handlers ||= {}
      @handlers[key] = { :block => proc, :re => key_to_regex(key) }

      @handler_keys ||= []
      @handler_keys << key
    end

    def find_handler(topic)
      return nil unless @handlers

      # check for direct hit
      if handler = @handlers[topic]
        handler[:block]

      # otherwise, test regexes
      else
        if key = @handler_keys.detect {|k| @handlers[k][:re].match(topic) }
          @handlers[key][:block]
        end
      end
    end

    def key_to_regex(key)
      Regexp.compile("^" + key.gsub('*', '[^\.]+').gsub('#', '.*') + "$")
    end
  end
end
