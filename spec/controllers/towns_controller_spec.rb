require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TownsController do

  describe "responding to GET index" do
    it "should expose all the towns as @towns" do
      Pub.should_receive(:towns).and_return(["Leeds", "Wakefield"])
      get :index
      assigns(:towns).should == ["Leeds", "Wakefield"]
    end
  
    it "should respond with success" do
      Pub.stub!(:towns).and_return(["Leeds", "Wakefield"])
      get :index 
     response.should be_success 
    end  
  end

end
