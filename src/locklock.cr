require "kemal"
require "./locklock/app"

app = Locklock::App.new

module Locklock
  VERSION = "0.1.0"

  get "/" do
    "Hello World!"
  end

  get "/lock/:name" do |env|
    env.response.content_type = "application/json"
    name = env.params.url["name"]

    app.lock!(name)
    {result: "success"}.to_json
  end

  get "/unlock/:name" do |env|
    env.response.content_type = "application/json"
    name = env.params.url["name"]

    app.unlock!(name)
    {result: "success"}.to_json
  end
end

Kemal.run
