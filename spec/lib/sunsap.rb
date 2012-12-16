require "spec_helper"

describe Sunsap do
  it "creates new reporters" do
    reporter = Sunsap::Reporter.new("test")
    reporter.send_test_message "Success!"
    reporter.queue.should eq ["Success!"]
  end
end
