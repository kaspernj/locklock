require "../spec_helper"
require "../../src/locklock/app"

describe Locklock::App do
  it "locks" do
    app = Locklock::App.new
    app.lock!("test")

    order = [] of Int32
    order << 1

    spawn do
      begin
        app.lock!("test")
        order << 2
        app.unlock!("test")
      rescue e
        puts "ERROR: #{e.message}"
      end
    end

    sleep 0.1

    app.unlock!("test")

    sleep 0.1

    app.synchronize("test") do
      order << 3
    end

    order << 4

    app.get_lock("test").locks_count.should eq 3
    order.should eq [1, 2, 3, 4]
  end
end
