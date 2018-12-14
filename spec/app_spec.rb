require_relative "./spec_helper.rb"
require_relative "../app.rb"

describe App do
  it "exists" do
    app = App
    app.should_not == nil
  end
end

