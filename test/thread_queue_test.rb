require 'test_helper'

require 'rantly'
require 'rantly/minitest_extensions'

class ThreadQueue::Test < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ThreadQueue::VERSION
  end
end

describe ThreadQueue do

  it 'will run all jobs added' do
    property_of {
      range 1, 100
    }.check {|tc|
      count = 0
      tp = ThreadQueue.new(tc)
      tc.times do
        tp.add -> { count += 1  }
      end
      count.must_equal tc
    }
  end

end
