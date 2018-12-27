require "date"

class Journal
  attr_reader :directory, :file_name, :file_path

  def initialize(date = Date.today, file = false)
    @date = date
    @directory = "/journals/"
    @directory_path = File.dirname(__FILE__) + @directory
    @file_name = file ? "file" : generate_file_name
    @file_path = File.join(@directory_path, @file_name)
  end

  def generate_file_name
    @date.to_s + ".yml"
  end

  def add_entry(text)
    @entry = text
    file = File.new(@file_path, "a")
    file.puts(@entry)
    file.close
  end

  def last_entry
    entries.last
  end

  def entries
    JSON.parse(File.read(@file_path))
  end

  def format_entry(text)
    {time: Time.now, description: text}
  end
end
