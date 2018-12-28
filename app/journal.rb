require "date"
require "securerandom"

class Journal
  attr_reader :directory, :file_name, :file_path

  def initialize(date = Date.today, file = false)
    @date = date
    @directory = "/journals/"
    @directory_path = File.dirname(__FILE__) + @directory
    @file_name = file ? "file" : generate_file_name
    @file_path = File.join(@directory_path, @file_name)
  end

  def [](uuid)
    entries.select {|entry| entry["uuid"] == uuid}.last
  end

  def add_entry(text)
    entry = format_entry(text)
    file = File.new(@file_path, "a")
    file.puts(entry)
    file.close
  end

  def generate_file_name
    @date.to_s + ".yml"
  end

  def last
    entries.last
  end

  def delete(uuid)
    entry_set = entries.reject {|entry| entry[uuid] == uuid}
    write(entry_set)
  end

  def write(entries)
    file = File.new(@file_path, "w")
    entries.each {|entry| file.puts(entry.to_json)}
    file.close
  end

  def entries
    begin
      File.read(@file_path)
          .split("\n")
          .map {|entries| JSON.parse(entries)}
    rescue
      []
    end
  end

  def format_entry(text)
    {
      time: Time.now,
      uuid: SecureRandom.uuid,
      description: text
    }.to_json
  end
end
