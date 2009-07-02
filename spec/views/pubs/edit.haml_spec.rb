require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/pubs/edit.haml" do
  include PubsHelper
  
  before(:each) do
    assigns[:pub] = @pub = Pub.make
  end

  it "should render edit form without a field for name" do
    render "/pubs/edit.haml"
    response.should have_tag("form[action=#{pub_path(@pub)}][method=post]") do
      without_tag('input#pub_name[name=?]', "pub[name]")
      with_tag('textarea#pub_description[name=?]', "pub[description]")
    end
  end
end