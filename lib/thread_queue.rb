require "thread_queue/version"

class ThreadQueue

  def initialize *args

  end

  def add item
    item.call
  end

end
