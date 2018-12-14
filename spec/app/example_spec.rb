require_relative "../../spec/spec_helper.rb"
require_relative "../../app/example.rb"

describe Example do

  it "exists" do
    example = Example.new
    example.should_not == nil
  end
end

