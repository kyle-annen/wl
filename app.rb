# load up all app files

require 'active_record'

Dir[File.expand_path('app/**/*.rb', File.dirname(__FILE__))].each do |file|
    require file
end
