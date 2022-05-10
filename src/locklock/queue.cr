class Locklock::Queue
  def initialize
    @waiting = [] of Channel
  end

  def pop
    raise "No one is waiting" if @waiting.empty?
  end

  def push
    channel = Channel(Integer).new
    @waiting.push(channel)
    channel
  end

  def waiting?
    @waiting.length > 0
  end
end
