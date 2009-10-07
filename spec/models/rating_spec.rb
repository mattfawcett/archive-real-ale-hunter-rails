require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Rating do

  it "should create a new instance given valid attributes" do
    rating = Rating.make
    rating.should be_valid
  end
  
  describe "rating allowance" do
    it "should not allow a user to have more than 1 rating per pub" do
      rating_1 = Rating.make
      rating_2 = Rating.make_unsaved(:pub => rating_1.pub, :user => rating_1.user)
      rating_2.should_not be_valid
    end
    
    it "should allow 2 different users to have a rating for a pub" do
      rating_1 = Rating.make
      rating_2 = Rating.make_unsaved(:pub => rating_1.pub)
      rating_2.should be_valid
    end
    
    it "should allow 1 user to have ratings for multiple pubs" do
      rating_1 = Rating.make
      rating_2 = Rating.make_unsaved(:user => rating_1.user)
      rating_2.should be_valid
    end
  end
  
  it "must not allow a value outside 0 - 10" do
    %w(beer_quality beer_selection atmosphere price overall_option).each do |field|
      rating = Rating.make_unsaved(field => -1) 
      rating.should_not be_valid
      rating = Rating.make_unsaved(field => 11) 
      rating.should_not be_valid
    end
  end
  
  describe "awarding pints" do
    it "should add 3 pints to the user on creation" do
      rating = Rating.make_unsaved
      user = ratingpub.user
      user.should_receive(:add_pints).with(3)
      rating.save
    end
  end
 
end
