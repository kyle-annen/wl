# frozen_string_literal: true

require_relative '../../spec/spec_helper.rb'
require_relative '../../app/journal.rb'

describe Journal do
  def test_journal_filename
    'test-journal.log'
  end

  def test_filepath
    "./journals/#{test_journal_filename}"
  end

  def test_journal
    Journal.new(file = 'test-journal')
  end

  after(:each) do
    file = test_journal.file_path
    File.delete(file) if File.exist?(file)
  end

  describe '#initialize' do
    it 'initialized with the default directory' do
      journal = test_journal
      journal.add_entry('test')
      journal.directory.should == '/journals/'
    end
  end

  describe '#file_name' do
    it 'returns the filename' do
      journal = test_journal
      journal.add_entry('test entry 1')

      journal.file_name.should == test_journal_filename
    end
  end

  describe '#add_entry' do
    it 'adds the entry to the last line of the log' do
      journal = test_journal
      test_entry = 'this is only a test'

      journal.add_entry(test_entry)

      entry = journal.last
      entry['description'].should == test_entry
      entry['description'].class.should == String
      entry['time'].class.should == Time
      entry['uuid'].class.should == String
    end
  end

  describe '#format_entry' do
    it 'formats the entry as a hash' do
      journal = test_journal
      test_entry = 'we are testing here'

      journal.add_entry(test_entry)

      journal.last.class.should == Hash
    end

    it 'adds a uuid for each entry' do
      journal = test_journal
      test_entry = 'is this thing on?'

      journal.add_entry(test_entry)

      journal.last.keys.should include('uuid')
    end
  end

  describe '#last_entry' do
    it 'returns the last entry of the day' do
      journal = test_journal
      test_entry = 'modulating the bit manipulators'

      journal.add_entry(test_entry)

      journal.last['description'].should == test_entry
    end
  end

  describe '#[]' do
    it 'returns a journal entry by uuid' do
      journal = test_journal
      test_entry = 'modulating the bit manipulators'

      journal.add_entry(test_entry)
      last_entry = journal.last
      uuid = last_entry['uuid']

      last_entry.should == journal[uuid]
    end
  end

  describe '#entries' do
    it 'returns the list of entries' do
      journal = test_journal
      test_entry = 'modulating the bit manipulators'

      journal.add_entry(test_entry)
      journal.add_entry(test_entry)
      journal.add_entry(test_entry)

      journal.entries.class.should == Array
      journal.entries.count.should == 3
    end

    it 'returns an empty array if no entries' do
      journal = test_journal

      journal.entries.should == []
    end
  end

  describe '#delete' do
    it 'deletes a journal entry' do
      journal = test_journal
      test_entry = 'modulating the bit manipulators'
      journal.add_entry(test_entry)
      uuid = journal.last['uuid']

      journal.delete(uuid)

      journal[uuid].should.nil?
    end
  end

  describe '#report' do
    it 'returns a formatted report of entries' do
      journal = test_journal
      journal.add_entry('this is a test')

      report = journal.report

      report.split("\n").count.should == 1
    end

    it 'returns a report of correct length' do
      journal = test_journal

      journal.add_entry('this is a test')
      journal.add_entry('this is a test')
      journal.add_entry('this is a test')

      report = journal.report
      report.split("\n").count.should == 3
      report.split("\n").first.should include('this is a test')
    end
  end
end
