require File.dirname(__FILE__)+'/spec_helper'

include Restfully
describe Collection do

  it "should have all methods of a hash" do
    collection = Collection.new("uri", session=mock('session'))
    collection.size.should == 0
    res = collection << (resource = mock(Resource, :guid => '/sites/rennes'))
    collection.size.should == 1
    collection.should == {'/sites/rennes' => resource}
    collection.should respond_to(:each)
    collection.should respond_to(:length)
  end
  
  it "should not load if already loaded and no force_reload" do
    collection = Collection.new("uri", mock("session"))
    collection.should_receive(:loaded?).and_return(true)
    collection.load(force_reload=false).should == collection
  end
  it "should load when force_reload is true [already loaded]" do
    collection = Collection.new("uri", session=mock("session", :logger => Logger.new(STDOUT)))
    collection.should_receive(:loaded?).and_return(true)
    session.should_receive(:get).and_return({})
    collection.load(force_reload=true).should == collection    
  end
  it "should load when force_reload is true [not loaded]" do
    collection = Collection.new("uri", session=mock("session", :logger => Logger.new(STDOUT)))
    collection.should_receive(:loaded?).and_return(false)
    session.should_receive(:get).and_return({})
    collection.load(force_reload=true).should == collection    
  end
end