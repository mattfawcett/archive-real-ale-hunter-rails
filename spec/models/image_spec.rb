require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
include ImageSpecHelper

describe Image do
  it { should belong_to(:user) }
  it { should belong_to(:pub) }
  
  describe "named scope latest" do
    it "should get the n number of latest pubs" do
      @image_1 = create_image
      @image_2 = create_image(:created_at => Time.now.advance(:minutes => 1))
      Image.latest(1).should == [@image_2]
      Image.latest(2).should == [@image_2, @image_1]
    end
  end
  
  describe "awarding pints" do
    it "should add 3 pints to the user on creation" do
      image = new_image
      user = image.user
      user.should_receive(:add_pints).with(3)
      image.save
    end
  end
end
