require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  it { should have_many(:pubs) }
  it { should have_many(:images) }
  it { should have_many(:visits) }
  it { should have_many(:ratings) }
  
  def self.latest(n)
    #bug in rails is why this isn't in a named_scope https://rails.lighthouseapp.com/projects/8994/tickets/2346-named_scope-doesnt-override-default_scopes-order-key
    find(:all, :order => "created_at DESC", :limit => n)
  end
  
  describe "has_rated?" do
    before(:each) do
      @user = User.make
      @pub_1 = Pub.make
      @pub_1.ratings.make(:user => @user)
      @pub_2 = Pub.make
      @pub_2.ratings.make(:user => User.make)
    end
    
    it "should return true if the user has reviews this pub" do
      @user.should have_rated(@pub_1)
    end
    
    it "should return false if the user has not rated this pub" do
      @user.should_not have_rated(@pub_2)
    end
  end
  
  describe "rating_for" do
    before(:each) do
      @user = User.make
      @pub_1 = Pub.make
      @rating = @pub_1.ratings.make(:user => @user)
      @pub_2 = Pub.make
      @pub_2.ratings.make(:user => User.make)
    end
    
    it "should return the rating if the user has reviews this pub" do
      @user.rating_for(@pub_1).should == @rating
    end
    
    it "should return nil if the user has not rated this pub" do
      @user.rating_for(@pub_2).should be_nil
    end
  end
  
  describe "add pints" do
    it "should add the number of pints passed in and save the user" do
      user = User.make
      user.add_pints(10)
      user.pints.should eql(110)
    end
  end
end
