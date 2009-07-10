require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Visit do
  it { should belong_to(:user) }
  it { should belong_to(:pub) }
  it { should belong_to(:user) }
  it { should have_many(:beers) }
  
  it "should have a named scope called latest" do
    Visit.should have_named_scope(:latest, :limit => 5)
  end
end
