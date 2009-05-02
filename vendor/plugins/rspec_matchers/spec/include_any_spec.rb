require File.dirname(__FILE__) + '/../lib/include_any'

describe 'include_any matcher' do
  it "should pass when the target includes any of the specified elements" do
    (1..10).to_a.should include_any(5, 15, 25)
  end
  
  it "should fail when the target includes none of the specififed elements" do
    lambda do
      [1,3,5].should include_any(2, 4, 6)
    end.should raise_error(Spec::Expectations::ExpectationNotMetError)
  end
end
