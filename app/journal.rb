# frozen_string_literal: true

require 'date'
require 'time'
require 'securerandom'

class Journal
  attr_reader :directory, :file_name, :file_path

  def initialize(date = Date.today, file = false)
    @date = date
    @directory = '/journals/'
    @directory_path = File.dirname(__FILE__) + @directory
    @file_name = file ? 'file' : generate_file_name
    @file_path = File.join(@directory_path, @file_name)
  end

  def [](uuid)
    entries.select { |entry| entry['uuid'] == uuid }.last
  end

  def add_entry(text)
    entry = format_entry(text)
    file = File.new(@file_path, 'a')
    file.puts(entry)
    file.close
  end

  def delete(uuid)
    entry_set = entries.reject { |entry| entry['uuid'] == uuid }
    File.delete(@file_path)
    write(entry_set)
  end

  def entries
    return [] unless File.exist?(@file_path)

    entries = File.read(@file_path)
                  .split("\n")
                  .map { |entry| JSON.parse(entry) }
                  .select { |entry| entry['type'] == 'entry' }

    entries.each do |entry|
      entry['time'] = Time.parse(entry['time'])
    end
  end

  def format_entry(text)
    {
      time: Time.now,
      uuid: SecureRandom.uuid,
      description: text,
      type: 'entry'
    }.to_json
  end

  def format_report_line(entry)
    time = entry['time']
    "[#{time.ctime}] #{entry['description']}"
  end

  def generate_file_name
    @date.to_s + '.log'
  end

  def last
    entries.last
  end

  def report
    report = entries.map do |entry|
      format_report_line(entry)
    end
    report.join("\n")
  end

  def write(entries)
    file = File.new(@file_path, 'a')
    entries.each { |entry| file.puts(entry.to_json) }
    file.close
  end
end
