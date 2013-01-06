module Sunsap
  VERSION = '0.1.0'
  attr_accessor :reportername, :messages

  # The reporter
  class Reporter
    # Public: Create a new reporter
    #
    # reportername - the name of the reporter as a string
    #
    # Examples
    #
    #   reporter = Sunsap::Reporter.new("test")
    #   # => true
    #
    # Returns true
    def initialize(reportername)
      @queue = []

      # Public: Send a message to the queue
      #
      # m - message to send
      #
      # Example:
      #
      #   reporter.send_test_message "Success!"
      #   # => true
      #
      # Returns true
      self.class.send :define_method, "send_#{reportername}_message" do |m|
        @queue.push(m)
        true
      end

      # Public: View the queue
      #
      # Example:
      #
      #   reporter.queue
      #   # => ["Success!"]
      #
      # Returns Array of messages
      def queue
        @queue
      end
      true
    end
  end

  class Reader
    # Public: Make a reader
    #
    # reporter - reporter to read the queue of
    #
    # Examples:
    # 
    #     reader = Sunsap::Reader.new(Sunsap::Reporter.new("test"))
    #     # => true
    def initialize(reporter)
      @reporter = reporter
      true
    end
    
    # Public: Read the queue in a more friendly matter
    # Examples:
    # 
    #     reporter = Sunsap::Reporer.new("test")
    #     reporter.send_test_message("Success!")
    #     reader = Sunsap::Reader.new
    #     reader.read
    #     # => "Messages: 1, Queue: ["Success!"]"
    #
    # Returns Messages and the Queue
    def read
      queuesize = @reporter.queue.size
      queue = @reporter.queue.map do |m|
       "#{m}"
      end
      "Messages: #{queuesize}, Queue: #{queue}"
    end

    # Public: Read the queue if it's not empty
    #
    # Examples:
    #
    #     reporter = Sunsap::Reporer.new
    #     reader = Sunsap::Reader.new
    #     reader.read!
    #     # => error: RuntimeError: Queue was empty
    # Returns Messages and the Queue or raises RuntimeError if the queue is empty
    def read!
      queuesize = @reporter.queue.size
      unless queuesize >= 1
        raise "Queue was empty"
      else
        queue = @reporter.queue.map do |m|
          "#{m}"
        end
        "Messages: #{queuesize}, Queue: #{queue}"
      end
    end
  end
end
