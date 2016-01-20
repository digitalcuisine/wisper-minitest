require 'test_helper'
require 'wisper/minitest/assertions'

class TestRefuteBroadcast < Minitest::Test
  extend Minitest::Spec::DSL

  let(:event_name) { 'it_happened' }

  let(:broadcaster) do
    Class.new do
      include Wisper::Publisher
      public :broadcast
    end.new
  end

  let(:event1) { 'trololo' }
  let(:event2) { 'u mad?' }

  let(:non_matching_broadcast) do
    Proc.new do
      broadcaster.broadcast(event1)
      broadcaster.broadcast(event2)
    end
  end

  def test_passes_with_non_matching_event
    refute_broadcast(event_name, &non_matching_broadcast)
  end

  def test_passes_with_no_broadcast
    refute_broadcast(event_name) { }
  end

  def test_passes_with_non_matching_arguments
    refute_broadcast(event_name, :arg1, :arg2, &non_matching_broadcast)
  end

  def test_fails_on_matching_event
    assert_raises Minitest::Assertion do
      refute_broadcast(event_name) { broadcaster.broadcast(event_name) }
    end
  end

  def test_fails_with_descriptive_failure_message_on_matching_event
    exp = assert_raises Minitest::Assertion do
      refute_broadcast(event_name) { broadcaster.broadcast(event_name) }
    end

    assert_equal exp.message, "expected publisher not to broadcast #{event_name} event"
  end

  def test_fails_with_matching_event_and_arguments
    assert_raises Minitest::Assertion do
      refute_broadcast(event_name, :arg1, :arg2) { broadcaster.broadcast(event_name, :arg1, :arg2) }
    end
  end

  def test_fails_with_descriptive_failure_message_on_matching_event_and_arguments
    exp = assert_raises Minitest::Assertion do
      refute_broadcast(event_name, :arg1, :arg2) { broadcaster.broadcast(event_name, :arg1, :arg2) }
    end

    assert_equal exp.message, "expected publisher not to broadcast #{event_name} event with args: [:arg1, :arg2]"
  end

end
