require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SearchesController do
  describe "responding to GET index" do
    before(:each) { @mock_pubs = []}
    
    it "should call seach on Pub with the passed in terms and expose as @results" do
      Pub.should_receive(:search).with("Foleys", :page => nil, :per_page => 50).and_return(@mock_pubs)
      get :index, :terms => "Foleys"
      assigns(:results).should eql(@mock_pubs)
    end
    
    it "should respond with success" do
      Pub.stub!(:search).with("Foleys", :page => nil, :per_page => 50).and_return(@mock_pubs)
      get :index, :terms => "Foleys"
      response.should be_success
    end
  end
end
