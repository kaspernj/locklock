require "./spec_helper"

describe Locklock do
  it "renders" do
    get "/"
    response.body.should eq "Hello World!"
  end

  it "locks and unlocks" do
    get "/lock/test"
    response.body.should eq({result: "success"}.to_json)

    get "/unlock/test"
    response.body.should eq({result: "success"}.to_json)
  end
end
