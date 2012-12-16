module Sunsap
  VERSION = '0.1.0'
  attr_accessor :reportername, :messages

  class Reporter
    def initialize(reportername)
      mediator = Mediator.new
      mess     = Participant.new("#{reportername}", mediator)
      super mediator, mess

      self.class.send :define_method, "send_#{reportername}_message" do |message|
        mediator.notify "Sunsap", "#{message}"
      end
    end
  end
end

class Mediator
  def initialize
    @participants = Hash.new
  end

  def register(participant)
    @participants[participant.id] = participant
  end

  def notify(from, to, message)
    to_participant = @participants[to]
    to_participant.receive(from) unless to_participant.nil?
  end
end

class Participant
  def initialize(id, mediator)
    super id, mediator
    mediator.register(self)
  end

  def receive(from, message)
    "#{message}"
  end
end
