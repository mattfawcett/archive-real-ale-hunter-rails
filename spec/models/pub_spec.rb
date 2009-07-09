require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Pub do
  before(:each) do
    @pub = Pub.make
  end
  
  it { should belong_to(:user) }
  it { should have_many(:beers) }
  
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
end
