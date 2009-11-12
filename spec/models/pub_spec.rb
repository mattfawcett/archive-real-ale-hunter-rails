require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Pub do
  before(:each) do
    @pub = Pub.make
  end
  
  it { should belong_to(:user) }
  it { should have_many(:beers) }
  it { should have_many(:images) }
  it { should have_many(:visits) }
  it { should have_many(:ratings) }
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:address_1) }
  it { should validate_presence_of(:town) }
  it { should validate_presence_of(:post_code) }
  
  
  describe "named scope in_town" do
    it "should find pubs in the passed in town" do
      @pub_2 = Pub.make(:lat => 13, :lng => 123)
      @pub_3 = Pub.make(:town => "Wakefield", :lat => 13, :lng => 123)
      Pub.in_town("Leeds").should eql([@pub, @pub_2])
      Pub.in_town("Wakefield").should eql([@pub_3])
    end
  end
  
  describe "named scope latest" do
    it "should get the n number of latest pubs" do
      @pub_2 = Pub.make(:created_at => Time.now.advance(:minutes => 1))
      Pub.latest(1).should == [@pub_2]
      Pub.latest(2).should == [@pub_2, @pub]
    end
  end
  
  describe "named scope beginning_with_letter" do
    before(:each) do
      @albian = Pub.make(:name => 'Albian')
      @bradfield = Pub.make(:name => 'Bradfield')
    end
    
    it "should only give pubs starting with that letter" do
      Pub.beginning_with_letter("A").should == [@albian]
    end
    
    it "should be case insensitive" do
      Pub.beginning_with_letter("a").should == [@albian]
    end
    
    it "should return all if letter is nil" do
      Pub.beginning_with_letter(nil).should include(@albian)
      Pub.beginning_with_letter(nil).should include(@bradfield)
    end
    
  end
   
  it "should create a new instance given valid attributes" do    
    @pub.should be_valid
  end
  
  it "should have a named scope to retrieve all pubs, but only the bare minimum of columns" do
    Pub.should have_named_scope :all_optimised_for_cluster_for_map, :select => "id, lat, lng"
  end
  
  
  it "should have named scope for getting all details of pubs in a limited area" do
    @pub_1 = Pub.make(:lat => 42, :lng => -1.25)
    @pub_2 = Pub.make(:lat => 42, :lng => 7.25)
    @pub_3 = Pub.make(:lat => 40, :lng => -1.25)
    @pub_4 = Pub.make(:lat => 45.6, :lng => -1)
    Pub.within_boundreys(41.3, 45.6, -1.5, -1).should == [@pub_1, @pub_4]
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
      # @pub.lat.should == BigDecimal.new("53.7907075")
      # @pub.lng.should == BigDecimal.new("-1.5488214")
      assert @pub.lat > 53.79 && @pub.lat < 53.80
      assert @pub.lng > -1.56 && @pub.lng < 1.54
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
    
    it "should give back excperts if the excerpts flag is true" do
      @pub.stub!(:excerpts).and_return(mock(:address_1 => 'test', :address_2 => 'test', :town => 'test', :post_code => 'test'))
      @pub.address(excerpts=true).should eql("test, test, test, test")
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
  
  describe "has_ratings?" do
    it "should have ratings if there is more than 0 ratings" do
      @pub.stub!(:ratings).and_return([mock_model(Rating)])
      @pub.should have_ratings
    end
    
    it "should not have ratings if there is more than 0 ratings" do
      @pub.stub!(:ratings).and_return([])
      @pub.should_not have_ratings
    end
  end
  
  describe "towns" do
    it "should just return an array of unique town names sorted alphabetically" do
      @pub_2 = Pub.make
      @pub_3 = Pub.make(:town => "Wakefield", :lat => 13, :lng => 123)
      @pub_4 = Pub.make(:town => "London", :lat => 13, :lng => 123)
      Pub.towns.should eql(["Leeds", "London", "Wakefield"])
    end
  end
  
  describe "average_ratings" do
    it "should return the a rounded whole number for the average" do
      [1,3,5,0,4,1,1,2,3].each do |atmosphere|
        @pub.ratings.make(:atmosphere => atmosphere)
      end
      @pub.average_ratings[:atmosphere].should eql(2)
    end
  end
  
  describe "awarding pints" do
    it "should add 5 pints to the user on creation" do
      pub = Pub.make_unsaved
      user = pub.user
      user.should_receive(:add_pints).with(5)
      pub.save
    end
  end
end
