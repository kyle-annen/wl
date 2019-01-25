describe Item do
  it "can be instantiated" do
    item = Item.new

    item.class.should == Item
  end
end
