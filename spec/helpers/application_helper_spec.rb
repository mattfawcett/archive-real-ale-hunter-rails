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
  
  describe "display_username" do
    it "should show the username and show their number of pints whne you hover over it" do
      expected = '<span title="matt - 10 pints" class="dotted-line-username">matt</span>'
      mock_user = mock_model(User, :username => 'matt', :pints => 10)
      helper.display_username(mock_user).should eql(expected)
    end
  end
end
