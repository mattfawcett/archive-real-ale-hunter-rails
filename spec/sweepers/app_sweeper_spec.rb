require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AppSweeper do
  include ImageSpecHelper
  
  before(:each) do
    @pub = Pub.make_unsaved
  end
  
  describe "when I change a pub" do
    it "should clear the pubs json cache" do
      AppSweeper.should_receive(:expire_pubs_json)
      @pub.save
    end
    
    it "should expire the pubs page" do
      AppSweeper.should_receive(:expire_pub_page).with(@pub)
      @pub.save
    end
  end
  
  describe "when I update a visit" do
    it "should expire the pubs page cache" do
      @visit = @pub.visits.make_unsaved
      @visit.stub!(:pub).and_return(@pub)
      AppSweeper.should_receive(:expire_pub_page).with(@pub)
      @visit = @pub.save
    end
  end
  
  describe "when I update an image" do
    it "should expire the pubs page cache" do
      @image = new_image(:pub => @pub)
      @image.stub!(:pub).and_return(@pub)
      AppSweeper.should_receive(:expire_pub_page).at_least(:once).with(@pub)
      @image.save
    end
  end

end