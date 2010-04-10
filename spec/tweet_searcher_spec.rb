require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe TweetSearcher do
  before(:each) do
    @grove = Pub.make
    @mr_foleys = Pub.make(:name => "Mr Foleys", :address_1 => "Headrow", :address_2 => nil, :town => "Leeds", :post_code => "LS1 5RG")
    @victoria = Pub.make(:name => "Victoria Commercial Hotel", :address_1 => "28 Great George Street", :address_2 => nil, :town => "Leeds", :post_code => "LS1 3DL")
    @town_street_tavern = Pub.make(:name => "Town Street Tavern", :address_1 => "16-18 Town Street", :address_2 => nil, :town => "Horsforth", :post_code => "LS18 4RJ")
    
    @john = User.make(:username => "John", :twitter_username => "john_smith")
  end
  
  it "should create a visit for the nearest tweet if name not found in the tweet" do
    mock_tweet = Hashie::Mash.new(:from_user  => 'john_smith', 
                                  :geo => Hashie::Mash.new(:coordinates => [53.799206, -1.545382]),
                                  :text => "In the boozer having a few pots #realalehunter")
    Twitter::Search.stub!(:new).and_return([mock_tweet])
    TweetSearcher.run!
    visit = Visit.last
    visit.user.should == @john
    visit.pub.should == @mr_foleys
    visit.comments.should == "In the boozer having a few pots"
  end
  
  it "should create a visit for the near pub that matches name if a match found" do
    mock_tweet = Hashie::Mash.new(:from_user  => 'john_smith', 
                                  :geo => Hashie::Mash.new(:coordinates => [53.799206, -1.545382]),
                                  :text => "In the victoria having a few pots #realalehunter")
    Twitter::Search.stub!(:new).and_return([mock_tweet])
    TweetSearcher.run!
    visit = Visit.last
    visit.user.should == @john
    visit.pub.should == @victoria
    visit.comments.should == "In the victoria having a few pots"
  end
  
  it "should create a visit for the near pub that matches name if a match found even if there are special charachers" do
    mock_tweet = Hashie::Mash.new(:from_user  => 'john_smith', 
                                  :geo => Hashie::Mash.new(:coordinates => [53.799206, -1.545382]),
                                  :text => "In the vic'toria having a few pots #realalehunter")
    Twitter::Search.stub!(:new).and_return([mock_tweet])
    TweetSearcher.run!
    visit = Visit.last
    visit.user.should == @john
    visit.pub.should == @victoria
    visit.comments.should == "In the vic'toria having a few pots"
  end
  
  it "should not create a visit if there is no pub near the geo location"
  
  it "should not add a visit if that pub has visited by that person today"
  
  it "should allow unknown twitter users"
end
