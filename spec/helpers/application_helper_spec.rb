require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
include ImageSpecHelper

describe ApplicationHelper do

  describe "alt textpub_photo_alt_text" do
    it "should be in the format of [name] - uploaded by [user], [so long ago]" do
      @image = create_image
      @image.stub!(:created_at).and_return(2.hours.ago)
      helper.pub_photo_alt_text(@image).should eql("Photo of the Grove - uploaded by PhotoMan about 2 hours ago")
    end
  end
  
end
