require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Visit do
  it { should belong_to(:user) }
  it { should belong_to(:pub) }
  it { should belong_to(:user) }
  it { should have_many(:beers) }

  describe "named scope latest" do
    it "should get the n number of latest pubs" do
      @visit_1 = Visit.make
      @visit_2 = Visit.make(:created_at => Time.now.advance(:minutes => 1))
      Visit.latest(1).should == [@visit_2]
      Visit.latest(2).should == [@visit_2, @visit_1]
    end
  end
  
  describe "awarding pints" do
    it "should add 3 pints to the user on creation" do
      visit = Visit.make_unsaved
      user = visit.user
      user.should_receive(:add_pints).with(3)
      visit.save
    end
  end
  
end
