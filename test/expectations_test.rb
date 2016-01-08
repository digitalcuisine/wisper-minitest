require 'test_helper'
require 'wisper/minitest/expectations'

class TestExpectations < Minitest::Test
  extend Minitest::Spec::DSL

  let(:event_name) { 'it_happened' }

  let(:broadcaster) do
    Class.new do
      include Wisper::Publisher
      public :broadcast
    end.new
  end

  def test_must_broadcast_no_args
    proc{ broadcaster.broadcast(event_name) }.must_broadcast(event_name)
  end

  def test_must_broadcast_with_args
    proc{ broadcaster.broadcast(event_name, :arg1) }.must_broadcast(event_name, :arg1)
    proc{ broadcaster.broadcast(event_name, :arg1) }.must_broadcast(event_name)
  end

  def test_wont_broadcast_no_args
    proc{ }.wont_broadcast(event_name)
    proc{ }.wont_broadcast(event_name, :arg1)
  end

  def test_wont_broadcast_with_args
    proc{ broadcaster.broadcast(event_name) }.wont_broadcast(event_name, :arg1)
  end
end
