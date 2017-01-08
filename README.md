Thread Queue Kata: A Property Based TDD Kata in Ruby using Rantly
=====

Introduction
------------

Setup
-----

You have ruby installed.

You have [git](http://git-scm.com/downloads) installed.

``git clone https://github.com/zhon/thread-queue-kata``

You have ``bundle`` installed (``gem install bundle``)

``bundle install``

## 0. Coming up to speed

## 1. Story: Write a Threaded Queue

### 1.0.0 Fail (Red)

``test/thread_queue_test.rb``
```ruby
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
```
### 1.0.1. Pass (Green)

``lib/thread_queue.rb``

```ruby
class ThreadQueue

  def initialize *args

  end

  def add item
    item.call
  end

end
```



