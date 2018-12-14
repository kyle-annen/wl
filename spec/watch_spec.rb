require_relative "../spec/spec_helper.rb"
require_relative "../lib/example.rb"

describe Example do

  it "loads configs" do
    watch = Example.new
    watch.should.not == nil
  end
end

