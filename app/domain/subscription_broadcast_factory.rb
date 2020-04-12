class SubscriptionBroadcastFactory
  class FakeBroadcaster
    def broadcast
      true
    end
  end

  def self.for_event(event)
    model_name = event.recordable.class.name

    begin
      "#{model_name}SubscriptionBroadcast".classify.new(event)
    rescue => e
      puts "no broadcaster for #{event.recordable.class}"
      FakeBroadcaster.new
    end
  end
end
