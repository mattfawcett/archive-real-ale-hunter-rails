require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Api::PubsController do
  describe "responding to GET search" do
    before(:each) do
      @pubs = [Pub.make]
      Pub.stub!(:search).and_return(@pubs)
    end

    it "should respond wih success" do
      get :search, :q => "Grove"
      response.should be_success
    end

    it "should return the pubs as json" do
      get :search, :q => "Grove"
      response.headers['Content-Type'].should =~ /json/
    end

    describe "when searching by town" do
      it "should search for conditions based from town" do
        Pub.should_receive(:search).with("*", :conditions => {"town" => "Leeds"}).and_return(@pubs)
        get :search, :q => "Leeds", :by => "town"
      end
    end

    describe "when searching by pub name" do
      it "should search for conditions based from pub name" do
        Pub.should_receive(:search).with("*", :conditions => {"name" => "Grove"}).and_return(@pubs)
        get :search, :q => "Grove", :by => "name"
      end
    end

    describe "doing a generic search" do
      it "should just do a normal search" do
        Pub.should_receive(:search).with("Best")
        get :search, :q => "Best"
      end
    end
    
    it "should include additional methods" do
      Pub.stub!(:search).and_return(@pubs)
      get :search, :q => "Grove"
      response.body.should =~ /number_of_images/
      response.body.should =~ /number_of_ratings/
      response.body.should =~ /average_ratings/
    end
  end

  describe "responding to GET closest" do
    before(:each) do
      @pub = Pub.make
      Pub.stub!(:find, :with => [:all,{ :origin =>["53","-1"], :within => 100, :order => :distance, :limit => 5}]).and_return([@pub])
    end
    
    it "should respond with success" do
      get :closest, :lat => "53", :lon => "-1"
      response.should be_success
    end
    
    it "should return the pubs in json format" do
      get :closest, :lat => "53", :lon => "-1"
      response.headers['Content-Type'].should =~ /json/
    end
    
    it "should search by the lat and lon defaulting to a limit of 5" do
      Pub.should_receive(:find, :with => [:all, {:origin =>["53","-1"], :within => 100, :order => :distance, :limit => 5}]).and_return([@pubs])
      get :closest, :lat => "53", :lon => "-1"      
    end
    
    it "should allow a custom limit" do
      Pub.should_receive(:find, :with => [:all, {:origin =>["53","-1"], :within => 100, :order => :distance, :limit => 20}]).and_return([@pubs])
      get :closest, :lat => "53", :lon => "-1", :limit => 20
    end
    
    it "should include additional methods" do
      get :closest, :lat => "53", :lon => "-1"
      puts "BODY IS #{response.body}"
      response.body.should =~ /number_of_images/
      response.body.should =~ /number_of_ratings/
      response.body.should =~ /average_ratings/
    end
  end

  describe "responding to GET show" do
    before(:each) do
      @pub = Pub.make
      Pub.stub!(:find).and_return(@pub)
    end
    
    it "should respond with success" do
      get :show, :id => @pub.id
      response.should be_success
    end
    
    it "should return the pub as json" do
      get :show, :id => @pub.id
      response.headers['Content-Type'].should =~ /json/
    end
    
    it "should include additional methods" do
      get :show, :id => @pub.id
      response.body.should =~ /number_of_images/
      response.body.should =~ /number_of_ratings/
      response.body.should =~ /average_ratings/
    end
  end
end