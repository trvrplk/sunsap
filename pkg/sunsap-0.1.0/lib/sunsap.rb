module Sunsap
  VERSION = '0.1.0'
  attr_accessor :reportername, :messages

  class Reporter
    def initialize(reportername)
      @queue = []
      self.class.send :define_method, "send_#{reportername}_message" do |m|
        @queue.push(m)
      end

      def queue
        @queue
      end
    end
  end
end
