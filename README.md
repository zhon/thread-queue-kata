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

  it 'runs all jobs' do
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

### 1.0.2 Fail

``test/thread_queue_test.rb``
```ruby
  it 'runs jobs concurrently' do
    property_of {
      range 1, 10
    }.check {|tc|
      tp = ThreadQueue.new(tc)
      t = Time.now.to_f
      tc.times do
        tp.add -> { sleep 0.01  }
      end
      (Time.now.to_f - t).must_be :<, 0.01 + 0.002 * tc , "Thread count #{tc}"
    }
  end
```

### 1.0.3 Pass (sorta)

``lib/thread_queue.rb``
```ruby
  def add item
    Thread.new {
      item.call
    }
  end
```

``test/thread_queue_test.rb``
```diff
  it 'runs all jobs' do
    .
    .
    .
      tc.times do
        tp.add -> { count += 1  }
      end
+      sleep 0.003
      count.must_equal tc
    }
  end
```

### 1.0.4 Refactor


``test/thread_queue_test.rb``
```diff
  it 'runs all jobs' do
      tc.times do
        tp.add -> { count += 1  }
      end
-      sleep 0.003
+      tp.join
      count.must_equal tc
    }
  end
```

``lib/thread_queue.rb``
```ruby
class ThreadQueue
  .
  .
  .
  def join
    sleep 0.003
  end
```

### 1.0.5 Refactor to real implementation


Sleep in an implementation is a code smell.


``lib/thread_queue.rb``
```ruby
class ThreadQueue

  def initialize *args
    @threads = []
  end

  def add item
    @threads << Thread.new {
      item.call
    }
  end

  def join
    @threads.each(&:join)
  end

end
```

Join will help out our ``concurrent`` test also.

``test/thread_queue_test.rb``
```diff
  it 'runs jobs concurrently' do
    .
    .
    .
      tc.times do
        tp.add -> { sleep 0.01  }
      end
+      tp.join
      (Time.now.to_f - t).must_be :<, 0.01 + 0.002 * tc , "Thread count #{tc}"
    }
  end
```

