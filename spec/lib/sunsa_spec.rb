require "spec_helper"

describe Sunsap do
  it "creates new reporters" do
    reporter = Sunsap::Reporter.new("test")
    reporter.send_test_message "Success!"
    reporter.queue.should eq ["Success!"]
  end

  it "can read things from reporters" do
    reporter = Sunsap::Reporter.new("test")
    reporter.send_test_message "Success!"
    reader = Sunsap::Reader.new(reporter)
    results = reader.read
    results[:messages].should eq 1
    results[:queue].should eq ["Success!"]
  end

  it "can read things from reporters if called with a '!'" do
    reporter = Sunsap::Reporter.new("test")
    reader = Sunsap::Reader.new(reporter)
    expect { results = reader.read_friendly! }.to raise_error RuntimeError
  end
  it "can read things from reporters in a friendly way" do
    reporter = Sunsap::Reporter.new("test")
    reporter.send_test_message "Success!"
    reader = Sunsap::Reader.new(reporter)
    results = reader.read_friendly
    results.should eq 'Messages: 1, Queue: ["Success!"]'
  end

  it "won't accept empty queues if `read_friendly` is called with a '!'" do
    reporter = Sunsap::Reporter.new("test")
    reader = Sunsap::Reader.new(reporter)
    expect { results = reader.read_friendly! }.to raise_error RuntimeError
  end
end
