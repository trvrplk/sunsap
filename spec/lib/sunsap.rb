require "spec_helper"

describe "Sunsap" do
  it "creates new reporters" do
    reporter = Sunsap::Reporter.new(name: "test")
    reporter.send(message: "Success!")
    reporter.test_count.should be "1"
  end
end
