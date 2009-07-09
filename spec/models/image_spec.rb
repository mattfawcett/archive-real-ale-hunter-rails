require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
include ImageSpecHelper

describe Image do
  it { should belong_to(:user) }
  it { should belong_to(:pub) }
  
  it "should have a named scope called latest wihich returns last 4 images" do
    Image.should have_named_scope(:latest, :limit => 4)
  end
  
  
end
