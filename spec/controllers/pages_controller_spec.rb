require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PagesController do

  describe "responding to GET whats_new" do
    it "should respond with success" do
      get :whats_new
      response.should be_success
    end
    
    it "should expose the 10 latest pubs as @pubs" do      
      pubs = []
      Pub.should_receive(:latest).with(10).and_return(pubs)
      get :whats_new
      assigns(:pubs).should eql(pubs)            
    end
    
    it "should expose the 10 latest visits as @visits" do
      visits = []
      Visit.should_receive(:latest).with(10).and_return(visits)
      get :whats_new
      assigns(:visits).should eql(visits)
    end
    
    it "should expose the 9 latest images as @images" do
      images = []
      Image.should_receive(:latest).with(9).and_return(images)
      get :whats_new
      assigns(:images).should eql(images)
    end
    
  end

end
