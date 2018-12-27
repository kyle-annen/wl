require_relative "../../spec/spec_helper.rb"
require_relative "../../app/journal.rb"

describe Journal do
  describe "#initialize" do
    it "initialized with the default directory" do
      journal = Journal.new
      journal.directory.should == "log"
    end
  end

  describe "today" do
    it "returns the date of today" do
      journal = Journal.new
      journal.today.should == Date.today
    end
  end
end

