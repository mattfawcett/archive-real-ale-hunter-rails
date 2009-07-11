require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PubsController do
  
  before(:each) do
    @pub = Pub.make
  end

  describe "responding to GET index" do
    describe "when requesting html" do
      it "should expose all the pubs as @pubs" do
        Pub.should_receive(:find).with(:all).and_return([@pub])
        get :index
        assigns(:pubs).should == [@pub]
      end
      
      it "should give success" do
        Pub.stub!(:find).with(:all).and_return([@pub])
        get :index
        response.should be_success
      end
    end
    
    describe "when requesting json" do      
      it "should call all_optimised_for_cluster_for_map on Pub" do
        pubs_array = [@pub]
        Pub.should_receive(:all_optimised_for_cluster_for_map).and_return(pubs_array)
        pubs_array.should_receive(:to_json)
        get :index, :format => 'json'
      end
      
      it "should give success" do
        Pub.stub!(:all_optimised_for_cluster_for_map).and_return([])
        get :index, :format => 'json'
        response.should be_success
      end
    end
  end

end
