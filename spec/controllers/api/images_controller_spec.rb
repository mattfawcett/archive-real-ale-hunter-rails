require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Api::ImagesController do
  include ImageSpecHelper
  
  describe "responding to GET index" do
    before(:each) do
      @pub = Pub.make
      @image = create_image(:pub => @pub)
    end
    
    it "should respond with success" do
      get :index, :pub_id => @pub.id
      response.should be_success
    end
    
    it "should respond with Json" do
      get :index, :pub_id => @pub.id
      response.headers['Content-Type'].should =~ /json/
    end
    
    it "should include paths to the different image sizes" do
      get :index, :pub_id => @pub.id
      json = JSON.parse(response.body)
      json.length.should == 1
      json.first["image"]["name"].should eql("Photo of the Grove")
      json.first["image"]["files"]["original"].should =~ /txt/
    end
  end
end