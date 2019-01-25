require 'active_record'
require 'sqlite3'

Dir[File.expand_path('app/**/*.rb', File.dirname(__FILE__))].each do |file|
  require file
end

def db_configuration
  db_configuration_file = File.join(File.dirname(__FILE__), 'db', 'config.yml')
  YAML.load(File.read(db_configuration_file))
end

ENV["RACK_ENV"] ||= "production".freeze

ActiveRecord::Base.establish_connection(db_configuration[ENV["RACK_ENV"]])

