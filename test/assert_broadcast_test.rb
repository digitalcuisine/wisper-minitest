require 'test_helper'
require 'wisper/minitest/assertions'

class TestAssertBroadcast < Minitest::Test

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
  
  
  def test_passes_with_matching_event
    assert_broadcast(event_name) { broadcaster.broadcast(event_name) }
  end
  
  def test_fails_with_no_broadcast
    assert_raises MiniTest::Assertion do
      assert_broadcast(event_name) { }
    end
  end
  
  def test_fails_with_descriptive_failure_message_on_no_event
    exp = assert_raises MiniTest::Assertion do
      assert_broadcast(event_name) { }
    end
    
    assert_equal exp.message, "expected publisher to broadcast #{event_name} event (no events broadcast)"
  end
  
  def test_fails_with_non_matching_event
    assert_raises Minitest::Assertion do
      assert_broadcast(event_name, non_matching_broadcast)
    end
  end
  
  def test_fails_with_descriptive_failure_message_on_non_matching_event
    exp = assert_raises MiniTest::Assertion do
      assert_broadcast(event_name, non_matching_broadcast)
    end

    assert_equal exp.message, "expected publisher to broadcast #{event_name} event (not included in #{event1}, #{event2})"
  end
  
end
