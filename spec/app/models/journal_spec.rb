describe Journal do
  it "can be instantiated" do
    journal = Journal.new

    journal.class.should == Journal
  end
end
