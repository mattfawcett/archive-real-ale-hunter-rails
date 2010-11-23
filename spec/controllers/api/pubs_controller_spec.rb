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