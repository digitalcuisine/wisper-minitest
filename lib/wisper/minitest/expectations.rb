require 'minitest/unit'
require 'minitest/spec'
require 'wisper/minitest/assertions'

module Minitest::Expectations
  infect_an_assertion :assert_broadcast, :must_broadcast
  infect_an_assertion :refute_broadcast, :wont_broadcast
end
