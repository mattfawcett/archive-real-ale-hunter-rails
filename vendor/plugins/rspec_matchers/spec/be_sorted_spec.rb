require File.dirname(__FILE__) + '/../lib/be_sorted'

describe 'be_sorted matcher' do
  it "should pass when elements are sorted as specified" do
    (1..10).to_a.should be_sorted { |a, b| a <=> b }
  end
  
  it "should fail when elements are not sorted as specififed" do
    lambda do
      [10,3,6,7,2].should be_sorted { |a,b| a <=> b }
    end.should raise_error(Spec::Expectations::ExpectationNotMetError)
  end
end
