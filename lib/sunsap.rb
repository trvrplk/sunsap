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
    end
  end

  class Reader
    def initialize(reporter)
      @reporter = reporter
    end

    def read
      queuesize = @reporter.queue.size
      queue = @reporter.queue.map do |m|
       "#{m}"
      end
      "Messages: #{queuesize}, Queue: #{queue}"
    end
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
