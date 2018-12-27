require_relative "../../spec/spec_helper.rb"
require_relative "../../app/journal.rb"

describe Journal do
  def test_journal_filename
    "test-journal.yml"
  end

  def test_filepath
    "./journals/#{test_journal_filename}"
  end

  def test_journal
    Journal.new(file = "test-journal")
  end

  after(:each) do
    File.delete(test_journal.file_path)
  end

  describe "#initialize" do
    it "initialized with the default directory" do
      journal = test_journal
      journal.add_entry("test")
      journal.directory.should == "/journals/"
    end
  end

  describe "#file_name" do
    it "returns the filename" do
      journal = test_journal
      journal.add_entry("test entry 1")

      journal.file_name.should == test_journal_filename
    end
  end

  describe "#add_entry" do
    it "adds the entry to the last line of the log" do
      journal = test_journal
      test_entry = "this is only a test"

      journal.add_entry(test_entry)
      contents = File.read(journal.file_path).split("\n")

      contents.last.should include(test_entry)
    end
  end

  describe "#last_entry" do
    it "returns the last entry of the day" do
      journal = test_journal
      test_entry = "modulating the bit manipulators"

      journal.add_entry(test_entry)

      journal.last_entry.should include(test_entry)
    end
  end
end

