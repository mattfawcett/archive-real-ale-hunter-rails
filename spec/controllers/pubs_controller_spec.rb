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
      
      it "should give html back" do
        Pub.stub!(:find).with(:all).and_return([@pub])
        get :index
        response.headers['Content-Type'].should =~ /text\/html/
      end
    end
    
    describe "when requesting json" do 
      describe "when wanting all pubs" do
        it "should call all_optimised_for_cluster_for_map on Pub" do
          pubs_array = [@pub]
          Pub.should_receive(:all_optimised_for_cluster_for_map).at_least(:once).and_return(pubs_array)
          pubs_array.should_receive(:to_json)
          get :index, :format => 'json'
        end      
        
        it "should give success" do
          Pub.stub!(:all_optimised_for_cluster_for_map).and_return([])
          get :index, :format => 'json'
          response.should be_success
        end
        
        it "should not do a normal expensive find" do
          Pub.stub!(:all_optimised_for_cluster_for_map).and_return([])
          Pub.should_not_receive(:find).with(:all)
          get :index, :format => 'json'
        end
        
        it "should give json back" do
          Pub.stub!(:all_optimised_for_cluster_for_map).and_return([])
          get :index, :format => 'json'
          response.headers['Content-Type'].should =~ /json/
        end
      end
      
      describe "when limiting to pubs in a certain area" do
        it "should call all_optimised_for_cluster_for_map on Pub" do
          pubs_array = [@pub]
          Pub.should_receive(:within_boundreys).at_least(:once).with("53.79190566459485", "53.80711346956182", "-1.567397117614746", "-1.5300607681274414").and_return(pubs_array)
          pubs_array.should_receive(:to_json)
          get :index, :format => 'json', :min_lat => "53.79190566459485", :max_lat => "53.80711346956182", :min_lng => "-1.567397117614746", :max_lng => "-1.5300607681274414"
        end      
        
        it "should give success" do
          Pub.stub!(:within_boundreys).and_return([])
          get :index, :format => 'json', :min_lat => "53.79190566459485", :max_lat => "53.80711346956182", :min_lng => "-1.567397117614746", :max_lng => "-1.5300607681274414"
          response.should be_success
        end        
        
        it "should give json back" do
          Pub.stub!(:within_boundreys).and_return([])
          get :index, :format => 'json', :min_lat => "53.79190566459485", :max_lat => "53.80711346956182", :min_lng => "-1.567397117614746", :max_lng => "-1.5300607681274414"
          response.headers['Content-Type'].should =~ /json/
        end
      end
      
    end
  end
  
  describe "rsponding to GET show" do
    describe "when requesting html" do
      it "should find the pub" do
        Pub.should_receive(:find).with("12").and_return(@pub)
        get :show, :id => "12"
      end
      
      it "should expose the pub as @pub" do
        Pub.stub(:find).with("12").and_return(@pub)
        get :show, :id => "12"
        assigns(:pub).should eql(@pub)
      end
      
      it "should give success" do
        Pub.stub(:find).with("12").and_return(@pub)
        get :show, :id => "12"
        response.should be_success
      end
      
      it "should give html back" do
        Pub.stub(:find).with("12").and_return(@pub)
        get :show, :id => "12"
        response.headers['Content-Type'].should =~ /text\/html/
      end
    end
    
    describe "when requesting json" do
      it "should find the pub" do
        Pub.should_receive(:find).with("12").and_return(@pub)
        get :show, :id => "12", :format => 'json'
      end
      
      it "should expose the pub as @pub" do
        Pub.stub(:find).with("12").and_return(@pub)
        get :show, :id => "12", :format => 'json'
        assigns(:pub).should eql(@pub)
      end
      
      it "should give success" do
        Pub.stub(:find).with("12").and_return(@pub)
        get :show, :id => "12", :format => 'json'
        response.should be_success
      end
      
      it "should give json back" do
        Pub.stub(:find).with("12").and_return(@pub)
        get :show, :id => "12", :format => 'json'
        response.headers['Content-Type'].should =~ /json/
      end
    end
  end

end
