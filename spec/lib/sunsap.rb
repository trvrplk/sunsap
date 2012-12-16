require "spec_helper"

describe Sunsap do
  it "creates new reporters" do
    reporter = Sunsap::Reporter.new("test")
    reader = Sunsap::Reader.new
    reporter.send_test_message "Success!"
    reader.queue.should be ["Success!"]
  end
end
