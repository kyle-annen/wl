require "date"

class Journal
  attr_reader :directory

  def initialize(directory = "log")
    @directory = directory
  end

  def today
    Date.today
  end
end
