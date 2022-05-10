require "./lock"

class Locklock::App
  def initialize
    @locks = {} of String => Locklock::Lock
    @mutex = Mutex.new
  end

  def lock!(name : String)
    get_lock(name).lock!
  end

  def unlock!(name : String)
    get_lock(name).unlock!
  end

  def get_lock(name : String)
    @mutex.synchronize do
      @locks[name] = Locklock::Lock.new(name) unless @locks.has_key?(name)

      return @locks[name]
    end
  end

  def synchronize(name : String, &blk)
    get_lock(name).synchronize(&blk)
  end
end
