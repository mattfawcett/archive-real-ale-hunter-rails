require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MapsController do

  describe "responding to GET show" do
    it "should give success" do
      get :show
      response.should be_success
    end    
  end

end
