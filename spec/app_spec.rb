require_relative "./spec_helper.rb"
require_relative "../app/journal.rb"

describe "wl" do

  def test_journal
    Journal.new(file = "test")
  end

  after(:each) do
    file = "./app/journals/test.log"
    File.delete(file) if File.exists?(file)
  end

  it "is executable from command line" do
    result = `bin/wl -t this is a test`

    result.should_not == nil

    entry = test_journal.last
    description = entry["description"]
    description.should include("this is a test")
  end
end
