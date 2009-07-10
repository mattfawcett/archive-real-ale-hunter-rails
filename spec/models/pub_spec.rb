require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Pub do
  before(:each) do
    @pub = Pub.make
  end
  
  it { should belong_to(:user) }
  it { should have_many(:beers) }
  it { should have_many(:images) }
  it { should have_many(:visits) }
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:address_1) }
  it { should validate_presence_of(:town) }
  it { should validate_presence_of(:post_code) }
   
  it "should create a new instance given valid attributes" do    
    @pub.should be_valid
  end
  
  describe "post_code" do
    it { should allow_value("LS18 5DA").for(:post_code) }
    it { should allow_value("LS185DA").for(:post_code) } 
    it { should allow_value("LS1 5DA").for(:post_code) } 
    it { should_not allow_value("LS 5DA").for(:post_code) } 
    it { should_not allow_value("LS1 DA").for(:post_code) } 
    
    it "should add a space 3 letters from the right before validating" do
      @pub = Pub.make(:post_code => "LS268TT")
      @pub.post_code.should eql("LS26 8TT")
      @pub = Pub.make(:post_code => "LS68TT")
      @pub.post_code.should eql("LS6 8TT")
    end
  end
  
  describe "website validation" do
    it "should add http:// to the site if not their already" do
      @pub.website = "www.google.com"
      @pub.save
      @pub.website.should eql("http://www.google.com")
    end
    
    it "should not add http:// if the site already has http:// or https://" do
      @pub.website = "http://www.google.com"
      @pub.save
      @pub.website.should eql("http://www.google.com")
      
      @pub.website = "https://www.google.com"
      @pub.save
      @pub.website.should eql("https://www.google.com")
    end
    
    it "should not add http:// if the site is blank" do
      @pub.website = ""
      @pub.save
      @pub.website.should be_blank
    end
  end
  
  describe "Geocoding" do
    it "should have the latitude and longitude when I save a pub" do
      @pub = Pub.make                        
      @pub.lat.should == BigDecimal.new("53.7907075")
      @pub.lng.should == BigDecimal.new("-1.5488214")
    end
  end
  
  describe "name_and_town" do
    it "should be '[name] - [town]'" do
      @pub.name_and_town.should eql("Grove - Leeds")
    end
  end
  
  describe "address" do
    it "should be the full address on 1 line" do
      @pub.address.should eql("Back row, Holbeck, Leeds, LS11 5PL")
    end
    
    it "should handle nil fields" do
      @pub.address_1 = nil
      @pub.address.should eql("Holbeck, Leeds, LS11 5PL")
    end
  end
  
  describe "slug" do
    it "should be a URI escaped version of name_and_town" do
      @pub.slug.name.should eql("grove-leeds")
    end
  end
  
  describe "has_images?" do
    it "should have images if there is more than 0 images" do
      @pub.stub!(:images).and_return([mock_model(Image)])
      @pub.should have_images
    end
    
    it "should not have images if there is more than 0 images" do
      @pub.stub!(:images).and_return([])
      @pub.should_not have_images
    end
  end
  
  describe "has_visits?" do
    it "should have visits if there is more than 0 visits" do
      @pub.stub!(:visits).and_return([mock_model(Visit)])
      @pub.should have_visits
    end
    
    it "should not have visits if there is more than 0 visits" do
      @pub.stub!(:visits).and_return([])
      @pub.should_not have_visits
    end
  end
end
