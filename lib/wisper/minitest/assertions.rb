require 'minitest/unit'
require 'wisper/minitest/event_recorder'

module Minitest::Assertions

  module Messages

    def self.assertion_failure(event_recorder)
      msg = "expected publisher to broadcast #{event_recorder.event_name} event"
      if event_recorder.args.size == 0
        if event_recorder.broadcast_events.any?
          msg += " (not included in #{event_recorder.broadcast_events.map(&:first).join(', ')})"
        else
          msg += ' (no events broadcast)'
        end
      end
      msg += " with args: #{event_recorder.args.inspect}" if event_recorder.args.size > 0
      msg
    end

    def self.refutation_failure(event_recorder)
      msg = "expected publisher not to broadcast #{event_recorder.event_name} event"
      if event_recorder.args.size == 0
        if event_recorder.broadcast_events.count > 1
          msg += " (included in #{event_recorder.broadcast_events.map(&:first).join(', ')})"
        end
      end
      msg += " with args: #{event_recorder.args.inspect}" if event_recorder.args.size > 0
      msg
    end
  end

  def assert_broadcast(*args)
    event = args.shift
    blk = args.first.respond_to?(:call) ? args.shift : nil
    event_recorder = Wisper::Minitest::EventRecorder.new

    # Call the given block within a temporary global subscriber
    Wisper.subscribe(event_recorder) do
      if block_given?
        yield
      elsif blk.respond_to?(:call)
        blk.call
      end
    end

    test = event_recorder.broadcast?(event, *args)

    # Check that given event has been broadcast 
    assert test, Messages.assertion_failure(event_recorder)
  end

  def refute_broadcast(*args)
    event = args.shift
    blk = args.first.respond_to?(:call) ? args.shift : nil
    event_recorder = Wisper::Minitest::EventRecorder.new

    # Call the given block within a temporary global subscriber
    Wisper.subscribe(event_recorder) do
      if block_given?
        yield
      elsif blk.respond_to?(:call)
        blk.call
      end
    end

    test = event_recorder.broadcast?(event, *args)

    # Check that given event has not been broadcast
    refute test, Messages.refutation_failure(event_recorder)
  end
end
