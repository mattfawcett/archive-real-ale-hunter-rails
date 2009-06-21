require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Pub do
  before(:each) do
    @pub = Pub.make
  end
  
  it { should belong_to(:user) }
  
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
      @pub.geocode.latitude.should == BigDecimal.new("53.79178")
      @pub.geocode.longitude.should == BigDecimal.new("-1.551842")
    end
  end
  
  describe "name_and_town" do
    it "should be '[name] in [town]'" do
      @pub.name_and_town.should eql("Grove in Leeds")
    end
  end
end
