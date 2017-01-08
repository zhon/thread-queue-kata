require 'test_helper'

class ThreadQueue::Test < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ThreadQueue::VERSION
  end
end
