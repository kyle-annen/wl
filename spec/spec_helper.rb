app_root = File.expand_path(File.join(__dir__, "..", ".."))
$LOAD_PATH.unshift(app_root) unless $LOAD_PATH.include?(app_root)

require "pry"

RSpec.configure do |config|
  config.order = "random"

  config.expect_with :rspec do |expectations_config|
    expectations_config.syntax = %i[expect should]
  end

  config.mock_with :rspec do |mocks_config|
    mocks_config.syntax = :should
    mocks_config.verify_partial_doubles = true
  end

  config.filter_run_when_matching :focus

  config.before(:each) do
  end
end
