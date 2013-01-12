module Sunsap
  VERSION = '0.2.0'
  attr_accessor :reportername, :messages

  # The reporter
  class Reporter
    # Create a new reporter
    #
    #  @api public
    #  @param [reportername] the name of the reporter as a string
    #
    # @example Make a new reporter
    #
    #   reporter = Sunsap::Reporter.new("test")
    #   # => true
    #
    # @returns true
    def initialize(reportername)
      @queue = []

      # Send a message to the queue
      #
      # @api public
      # @param [m] message to send
      #
      # @example Send a message
      #
      #   reporter.send_test_message "Success!"
      #   # => true
      #
      # @returns true
      self.class.send :define_method, "send_#{reportername}_message" do |m|
        @queue.push(m)
        true
      end

      # View the queue
      #
      # @api public
      # @example Read a queue
      #
      #   reporter.queue
      #   # => ["Success!"]
      #
      # @returns Array of messages
      def queue
        @queue
      end
      true
    end
  end

  class Reader
    # Make a reader
    #
    # @params [reporter] reporter to read the queue of
    #
    # @example Make a new instance of the `Reader` class
    # 
    #     reader = Sunsap::Reader.new(Sunsap::Reporter.new("test"))
    #     # => true
    def initialize(reporter)
      @reporter = reporter
      true
    end
    # Read the queue the right way
    # @api public
    # @example Read a queue
    #     reporter = Sunsap::Reporer.new("test")
    #     reporter.send_test_message("Success!")
    #     reader = Sunsap::Reader.new
    #     reader.read
    #     # => {:messages => 1, :queue => ["Success!"]}
    
    def read
      {:messages => queuesize, :queue => queue}
    end

    # Read the queue if it's not empty
    #
    # @api public
    # @example Read a queue
    #
    #     reporter = Sunsap::Reporer.new
    #     reader = Sunsap::Reader.new
    #     reader.read!
    #     # => error: RuntimeError: Queue was empty
    #
    # @returns Messages and the Queue or raises RuntimeError if the queue is empty
    def read!
      unless queuesize >= 1
        raise "Queue was empty"
      else
        queue
      end
      {:messages => queuesize, :queue => queue}
    end

    # Read the queue in a more friendly matter
    #
    # @api public
    # @example Read a queue
    #     reporter = Sunsap::Reporer.new("test")
    #     reporter.send_test_message("Success!")
    #     reader = Sunsap::Reader.new
    #     reader.read
    #     # => "Messages: 1, Queue: ["Success!"]"
    #
    # @returns Messages and the Queue
    def read_friendly
      "Messages: #{queuesize}, Queue: #{queue}"
    end

    # Read the queue if it's not empty
    #
    # @api public
    # @example Read a queue
    #
    #     reporter = Sunsap::Reporer.new
    #     reader = Sunsap::Reader.new
    #     reader.read!
    #     # => error: RuntimeError: Queue was empty
    #
    # @returns Messages and the Queue or raises RuntimeError if the queue is empty
    def read_friendly!
      unless queuesize >= 1
        raise "Queue was empty"
      else
        queue
        "Messages: #{queuesize}, Queue: #{queue}"
      end
    end

    private

    def queue
      queue = @reporter.queue
    end

    def queuesize
      queuesize = @reporter.queue.size
    end
  end
end
