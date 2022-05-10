class Locklock::Lock
  getter :locks_count, :name

  def initialize(name : String)
    @name = name
    @locked = false
    @mutex = Mutex.new
    @locks_count = 0
  end

  def lock!
    @mutex.lock
    @locks_count += 1
    @locked = true
  end

  def locked?
    @locked
  end

  def synchronize
    lock!

    begin
      yield
    ensure
      unlock!
    end
  end

  def unlock!
    @locked = false
    @mutex.unlock
  end
end
